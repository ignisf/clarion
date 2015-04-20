require 'rails_helper'

RSpec.describe CallForParticipation, type: :model do
  it 'belongs to a conference' do
    conference = create :conference
    cfp = create(:call_for_participation, conference_id: conference.id)
    expect(CallForParticipation.find(cfp.id).conference).to eq conference
  end
end
