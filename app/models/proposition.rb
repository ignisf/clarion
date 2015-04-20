class Proposition < ActiveRecord::Base
  belongs_to :proposer, class_name: 'User'
  belongs_to :proposition_accepting, polymorphic: true
  belongs_to :proposable, polymorphic: true

  enum status: [:undecided, :approved, :rejected, :backup]
end
