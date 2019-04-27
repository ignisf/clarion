class Participation < ActiveRecord::Base
  belongs_to :participant, class_name: 'User'
  has_one :participant_with_personal_profile, class_name: 'Participant'
  belongs_to :event
  validates :participant_id, presence: true
  scope :approved, ->() { where approved: true }
  scope :pending, ->() { where.not approved: true }
end
