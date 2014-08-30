class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :length, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :abstract, presence: true
  validates :description, presence: true
  validates :track, inclusion: { in: (Conference.current.try(:tracks) || []) }

  belongs_to :track
  has_one :conference, through: :track
  belongs_to :user
end
