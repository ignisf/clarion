class Participation < ActiveRecord::Base
  belongs_to :participant, class_name: User
  belongs_to :event

  scope :approved, ->() { where approved: true }
  scope :pending, ->() { where.not approved: true }
end
