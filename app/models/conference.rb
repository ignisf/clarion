class Conference < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :email, presence: true, format: {with: /\A[^@]+@[^@]+\z/}
  validates :description, presence: true
  validates :planned_cfp_end_date, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_is_before_end_date
  validate :planned_cfp_end_date_is_before_start_date

  translates :title, :description

  has_many :tracks
  has_many :halls
  has_many :event_types
  has_many :events
  has_many :volunteer_teams
  has_many :volunteers
  has_one :call_for_participation, dependent: :destroy
  has_many :participants, -> { uniq }, class_name: 'User', through: :events
  has_many :participant_profiles, class_name: 'PersonalProfile'
  has_many :slots, through: :halls

  accepts_nested_attributes_for :tracks, :halls, :event_types, :volunteer_teams,
                                reject_if: :all_blank, allow_destroy: true

  after_create :create_call_for_participation

  def submissions_grouped_by_day
    submissions = events.group('date(events.created_at)').select('date(events.created_at) as created_at, count(events.id) as number')
    submissions.group_by { |s| s.created_at.to_date }
  end

  def submissions_grouped_by_confirmation_day
    submissions = events.joins(:proposition).approved.confirmed.group('date(propositions.confirmed_at)').select('date(propositions.confirmed_at) as confirmed_at, count(events.id) as number')
    submissions.group_by { |s| s.confirmed_at.to_date }
  end

  def update_vote_data!
    ConferenceVoteSummary.new(conference: self).save
  end

  def has_vote_results?
    vote_data_updated_at.present?
  end

  def has_voting_endpoint?
    vote_data_endpoint.present?
  end

  private

  def planned_cfp_end_date_is_before_start_date
    if planned_cfp_end_date.present? and start_date.present? and planned_cfp_end_date > start_date
      errors.add(:planned_cfp_end_date, :cannot_be_after_start_date)
    end
  end

  def start_date_is_before_end_date
    if start_date.present? and end_date.present? and start_date > end_date
      errors.add(:end_date, :cannot_be_before_start_date)
    end
  end

  class ConferenceVoteSummary
    include ActiveModel::Model

    attr_accessor :conference

    def number_of_ballots
      @number_of_ballots ||= remote_summary_data['number_of_ballots']
    end

    def ranking
      @ranking ||= remote_summary_data['ranking'].map { |ranking_entry| EventRanking.new ranking_entry }
    end

    def save
      conference.transaction do
        conference.update number_of_ballots_cast: number_of_ballots
        ranking.all?(&:save) or raise ActiveRecord::Rollback
        conference.touch :vote_data_updated_at
        conference.save or raise ActiveRecord::Rollback
      end
    end

    private

    def connection
      @connection ||= Faraday.new(url: conference.vote_data_endpoint + '/summary.json',
                                  headers: {'Content-Type' => 'application/json'})
    end

    def remote_summary_data
      @remote_summary_data ||= JSON.parse(connection.get do |request|
                                            request.body = {summary: {talk_ids: conference.events.pluck(:id)}}.to_json
                                          end.body)
    end

    class EventRanking
      include ActiveModel::Model

      attr_accessor :talk_id, :votes, :place

      def save
        Event.find(talk_id).update(number_of_votes: votes, rank: place)
      end
    end
  end
end
