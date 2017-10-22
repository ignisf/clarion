class Feedback < ActiveRecord::Base
  belongs_to :feedback_receiving, polymorphic: true

  validates :rating, presence: true, inclusion: {in: [2, 3, 4, 5 ,6]}
end
