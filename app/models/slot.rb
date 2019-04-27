class Slot < ActiveRecord::Base
  belongs_to :hall
  belongs_to :event, required: false
end
