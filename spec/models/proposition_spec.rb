require 'rails_helper'

RSpec.describe Proposition, type: :model do
  it 'belongs to a proposer' do
    user = create :user
    expect(create(:proposition, proposer: user).proposer).to eq user
  end

  it 'belongs to a proposition_accepting' do
    track = create :track
    expect(create(:proposition, proposition_accepting: track).proposition_accepting).to eq track
  end

  it 'belongs to a proposable' do
    event = create :event
    expect(create(:proposition, proposable: event).proposable).to eq event
  end

  it 'is invalid without an existing proposition_accepting'
  it 'is invalid without an existing proposable'
end
