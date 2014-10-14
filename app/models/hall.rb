class Hall < ActiveRecord::Base
  belongs_to :conference
  has_many :slots, dependent: :destroy

  validates :name, presence: true
end
