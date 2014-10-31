class Hall < ActiveRecord::Base
  belongs_to :conference
  has_many :slots
end
