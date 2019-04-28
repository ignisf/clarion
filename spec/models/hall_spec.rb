require "rails_helper"

RSpec.describe Hall, type: :model do
  it "is invalid without a name" do
    expect(build(:hall, name: "")).to have_error_on :name
  end

  it "belongs to a conference" do
    conference = create :conference
    expect(build(:hall, conference_id: conference.id).conference).to eq conference
  end

  it "has many slots" do
    hall = create :hall
    slot = create :slot, hall: hall
    expect(hall.slots).to include slot
  end

  it "destroys all associated slots when destroyed" do
    hall = create :hall
    create :slot, hall: hall
    expect { hall.destroy }.to change { Slot.count }.by(-1)
  end
end
