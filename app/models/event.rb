class Event < ActiveRecord::Base
  include Proposable

  validates :title, presence: true
  validates :length, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :abstract, presence: true
  validates :description, presence: true
  validates :agreement, acceptance: true

  scope :confirmed, -> { where.not confirmed_at: nil }
end
