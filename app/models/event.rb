class Event < ActiveRecord::Base
  include Proposable

  has_one :track, through: :proposition, source: :proposition_accepting, source_type: Track
  has_one :conference, through: :track

  validates :title, presence: true
  validates :length, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :abstract, presence: true
  validates :description, presence: true
  validates :agreement, acceptance: true

  scope :confirmed, -> { where.not confirmed_at: nil }
end
