require "rails_helper"

RSpec.describe Proposition, type: :model do
  it "belongs to a proposer" do
    user = create :user
    expect(create(:proposition, proposer: user).proposer).to eq user
  end

  it "belongs to a proposable" do
    event = create :event
    expect(create(:proposition, proposable: event).proposable).to eq event
  end

  it "is invalid without an existing proposable"
end
