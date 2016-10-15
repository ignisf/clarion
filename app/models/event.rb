class Event < ActiveRecord::Base
  include Proposable

  belongs_to :conference
  belongs_to :track
  has_one :slot

  has_many :participations, dependent: :destroy
  has_many :pending_participations, ->() { pending }, class_name: 'Participation'
  has_many :approved_participations, ->() { approved }, class_name: 'Participation'
  has_many :participants, through: :approved_participations
  has_many :participants_with_personal_profiles, through: :approved_participations, source: :participant_with_personal_profile
  has_many :conflict_counts, -> { order(number_of_conflicts: :desc) }, foreign_key: :left_id

  belongs_to :event_type

  scope :ranked, -> { where.not(ranked: nil).where.not(votes: nil) }

  validates :conference, presence: true
  validates :title, presence: true
  validates :abstract, presence: true
  validates :description, presence: true
  validates :agreement, acceptance: true
  validates :track, presence: true
  validate :track_belongs_to_the_selected_conference
  validates :language, inclusion: {in: I18n.available_locales.map(&:to_s)}, presence: true
  validates :event_type, presence: true
  validates :length, presence: true, numericality: {only_integer: true}
  validate :length_is_within_the_permitted_interval

  delegate :status, to: :proposition

  accepts_nested_attributes_for :participations, allow_destroy: true

  def all_participants_have_profiles?
    participants_with_personal_profiles.all? { |participant| participant.has_personal_profile? }
  end

  def proposer_profile
    proposer.personal_profile(conference)
  end

  def length
    read_attribute(:length) || event_type.try(:minimum_length)
  end

  def proposable_type
    event_type.name
  end

  def proposable_description
    {
      proposer_email: proposer_email,
      title: title,
      subtitle: subtitle,
      track: track.name,
      length: "#{length} m",
      language: language,
      abstract: abstract,
      description: description,
      notes: notes
    }
  end

  def ranked?
    conference.has_vote_results? and rank.present? and number_of_votes.present?
  end

  def per_cent_of_votes
    if conference.has_vote_results? and conference.number_of_ballots_cast > 0
      Rational(number_of_votes * 100, conference.number_of_ballots_cast)
    else
      Float::NAN
    end
  end

  private

  def track_belongs_to_the_selected_conference
    unless conference.present? and conference.tracks.include?(track)
      errors.add :track, :must_be_a_valid_track
    end
  end

  def length_is_within_the_permitted_interval
    unless length >= event_type.minimum_length and length <= event_type.maximum_length
      errors.add :length, :must_be_between, minimum: event_type.minimum_length, maximum: event_type.maximum_length
    end
  end
end
