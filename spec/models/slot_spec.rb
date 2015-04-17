require 'rails_helper'

RSpec.describe Slot, :type => :model do
  it 'belongs to a hall' do
    hall = create :hall
    expect(build(:slot, hall_id: hall.id).hall).to eq hall
  end

  it 'belongs to an event' do
    event = create :event
    expect(build(:slot, event_id: event.id).event).to eq event
  end
end
