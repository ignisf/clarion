class Event < ActiveRecord::Base
  include Proposable

  belongs_to :conference
  belongs_to :track
  has_one :slot

  has_many :participations, dependent: :destroy
  has_many :pending_participations, -> { pending }, class_name: "Participation"
  has_many :approved_participations, -> { approved }, class_name: "Participation"
  has_many :participants, through: :approved_participations
  has_many :participants_with_personal_profiles, through: :approved_participations, source: :participant_with_personal_profile
  has_many :conflict_counts, -> { order(number_of_conflicts: :desc) }, foreign_key: :left_id
  has_many :feedbacks, as: :feedback_receiving, dependent: :destroy

  belongs_to :event_type

  scope :ranked, -> { where.not(ranked: nil).where.not(votes: nil) }
  scope :approved, -> { where(propositions: {status: Proposition.statuses[:approved]})}

  validates :conference, presence: true
  validates :title, presence: true, length: {maximum: 65}
  validates :abstract, presence: true
  validates :description, presence: true
  validates :agreement, acceptance: true
  validates :track, presence: true
  validates :language, inclusion: {in: I18n.available_locales.map(&:to_s)}, presence: true
  validates :event_type, presence: true
  validates :length, presence: true, numericality: {only_integer: true}
  validate :length_is_within_the_permitted_interval
  validate :track_belongs_to_the_selected_conference
  validate :event_type_belongs_to_the_selected_conference

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
      notes: notes,
    }
  end

  def ranked?
    conference.has_vote_results? && rank.present? && number_of_votes.present?
  end

  def per_cent_of_votes
    if conference.has_vote_results? && (conference.number_of_ballots_cast > 0)
      Rational(number_of_votes * 100, conference.number_of_ballots_cast)
    else
      Float::NAN
    end
  end

  private

  def event_type_belongs_to_the_selected_conference
    unless conference.present? && conference.event_types.include?(event_type)
      errors.add :event_type, :must_be_a_valid_event_type
    end
  end

  def track_belongs_to_the_selected_conference
    unless conference.present? && conference.tracks.include?(track)
      errors.add :track, :must_be_a_valid_track
    end
  end

  def length_is_within_the_permitted_interval
    if event_type.present?
      unless (length >= event_type.minimum_length) && (length <= event_type.maximum_length)
        errors.add :length, :must_be_between, minimum: event_type.minimum_length, maximum: event_type.maximum_length
      end
    end
  end
end
