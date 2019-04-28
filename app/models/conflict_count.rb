class ConflictCount < ActiveRecord::Base
  belongs_to :left, class_name: "Event"
  belongs_to :right, class_name: "Event"
  has_one :conference, through: :left
end
