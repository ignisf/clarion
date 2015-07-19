class EventType < ActiveRecord::Base
  belongs_to :conference
  has_many :events

  translates :name, :description

  validates :name, presence: true, uniqueness: {scope: :conference, message: :must_be_unique_for_the_conference}
  validates :description, presence: true
end
