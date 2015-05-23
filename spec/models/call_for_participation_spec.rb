require 'rails_helper'

RSpec.describe CallForParticipation, type: :model do
  let(:cfp) { build :call_for_participation }

  it 'belongs to a conference' do
    conference = create :conference
    cfp = create(:call_for_participation, conference_id: conference.id)
    expect(CallForParticipation.find(cfp.id).conference).to eq conference
  end

  describe '#open?' do
    it 'returns true when the CFP has an opens_at date in the past' do
      cfp.opens_at = 10.minutes.ago

      expect(cfp.open?).to be true
    end

    it 'returns false when the CFP has no opens_at date' do
      cfp.opens_at = nil

      expect(cfp.open?).to be false
    end

    it 'returns false when the CFP has an opens_at date in the future' do
      cfp.opens_at = 10.minutes.from_now

      expect(cfp.open?).to be false
    end
  end

  describe '#closed?' do
    it 'returns true when the CFP has a closes_at date in the past' do
      cfp.closes_at = 10.minutes.ago

      expect(cfp.closed?).to be true
    end

    it 'returns false when the CFP has no closes_at date' do
      cfp.closes_at = nil

      expect(cfp.closed?).to be false
    end

    it 'returns false when the CFP has a closes_at date in the future' do
      cfp.closes_at = 10.minutes.from_now

      expect(cfp.closed?).to be false
    end
  end

  describe '#in_progress?' do
    it 'returns true when the CFP has been opened and has not been closed' do
      expect(cfp).to receive(:open?) { true }
      expect(cfp).to receive(:closed?) { false }

      expect(cfp.in_progress?).to be true
    end

    it 'returns false when the CFP has not been opened' do
      expect(cfp).to receive(:open?) { false }

      expect(cfp.in_progress?).to be false
    end

    it 'returns false when the CFP has been closed' do
      expect(cfp).to receive(:open?) { true }
      expect(cfp).to receive(:closed?) { true }

      expect(cfp.in_progress?).to be false
    end
  end
end
