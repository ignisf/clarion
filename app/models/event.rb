class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :length, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :abstract, presence: true
  validates :description, presence: true
  validates :agreement, acceptance: true

  belongs_to :track
  has_one :conference, through: :track
  belongs_to :user # XXX: Transition to candidate_speaker
  belongs_to :candidate_speaker, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :speakers, class_name: 'SpeakerProfile'

  enum state: [:undecided, :approved, :rejected, :backup]

  scope :confirmed, -> { where.not confirmed_at: nil }

  # XXX: this belongs in a decorator
  STATE_TO_GLYPH = {undecided: 'question-sign', rejected: 'remove', approved: 'ok', backup: 'retweet'}
  STATE_TO_CLASS = {undecided: 'warning', rejected: 'danger', approved: 'success', backup: 'info'}

  def confirmed?
    !!confirmed_at
  end

  private

  def self.inheritance_column
    'something'
  end
end
