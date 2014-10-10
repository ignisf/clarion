class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :length, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :abstract, presence: true
  validates :description, presence: true
  validates :track_id, inclusion: { in: (Conference.current.try(:tracks) || []).map(&:id) }
  validates :agreement, acceptance: true

  belongs_to :track
  has_one :conference, through: :track
  belongs_to :user # XXX: Transition to candidate_speaker
  belongs_to :candidate_speaker, class_name: 'User', foreign_key: 'user_id'

  after_create :send_new_event_notification

  enum state: [:undecided, :approved, :rejected, :backup]

  # XXX: this belongs in a decorator
  STATE_TO_GLYPH = {undecided: 'question-sign', rejected: 'thumbs-down', approved: 'thumbs-up', backup: 'retweet'}
  STATE_TO_CLASS = {undecided: 'warning', rejected: 'danger', approved: 'success', backup: 'info'}

  private

  def send_new_event_notification
    EventMailer.new_event_notification(self).deliver
  end
end
