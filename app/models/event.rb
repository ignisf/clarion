class Event < ActiveRecord::Base
  include Proposable

  belongs_to :conference
  belongs_to :track

  has_many :participations
  has_many :pending_participations, ->() { pending }, class_name: 'Participation'
  has_many :approved_participations, ->() { approved }, class_name: 'Participation'
  has_many :participants, through: :approved_participations

  belongs_to :event_type

  validates :title, presence: true
  validates :length, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :abstract, presence: true
  validates :description, presence: true
  validates :agreement, acceptance: true

  scope :confirmed, -> { where.not confirmed_at: nil }

  def proposer_profile
    proposer.personal_profile(conference)
  end
end
