require "rails_helper"

RSpec.describe CallForParticipation, type: :model do
  let(:conference) { create :conference }
  subject(:cfp) { build :call_for_participation, conference_id: conference.id }

  it "belongs to a conference" do
    conference = create :conference
    cfp = create(:call_for_participation, conference_id: conference.id)
    expect(CallForParticipation.find(cfp.id).conference).to eq conference
  end

  describe "#open?" do
    it "returns true when the CFP has an opens_at date in the past" do
      cfp.opens_at = 10.minutes.ago

      expect(cfp.open?).to be true
    end

    it "returns false when the CFP has no opens_at date" do
      cfp.opens_at = nil

      expect(cfp.open?).to be false
    end

    it "returns false when the CFP has an opens_at date in the future" do
      cfp.opens_at = 10.minutes.from_now

      expect(cfp.open?).to be false
    end
  end

  describe "#closed?" do
    it "returns true when the CFP has a closes_at date in the past" do
      cfp.closes_at = 10.minutes.ago

      expect(cfp.closed?).to be true
    end

    it "returns false when the CFP has no closes_at date" do
      cfp.closes_at = nil

      expect(cfp.closed?).to be false
    end

    it "returns false when the CFP has a closes_at date in the future" do
      cfp.closes_at = 10.minutes.from_now

      expect(cfp.closed?).to be false
    end
  end

  describe "#in_progress?" do
    it "returns true when the CFP has been opened and has not been closed" do
      expect(cfp).to receive(:open?) { true }
      expect(cfp).to receive(:closed?) { false }

      expect(cfp.in_progress?).to be true
    end

    it "returns false when the CFP has not been opened" do
      expect(cfp).to receive(:open?) { false }

      expect(cfp.in_progress?).to be false
    end

    it "returns false when the CFP has been closed" do
      expect(cfp).to receive(:open?) { true }
      expect(cfp).to receive(:closed?) { true }

      expect(cfp.in_progress?).to be false
    end
  end

  describe "#open!" do
    it "changes the status of the CFP to open" do
      expect { cfp.open! }.to change { cfp.open? }.from(false).to(true)
    end

    it "does not change the open time of the CFP when it has already been set" do
      cfp.opens_at = 10.minutes.ago
      expect { cfp.open! }.to_not change { cfp.opens_at }
    end

    it "unsets the close time of the CFP" do
      cfp.closes_at = 10.minutes.ago
      expect { cfp.open! }.to change { cfp.closes_at }.to(nil)
    end

    it "saves the record" do
      expect { cfp.open! }.to change { cfp.persisted? }.from(false).to(true)
    end
  end

  describe "#close!" do
    it "changes the status of the CFP to closed" do
      expect { cfp.close! }.to change { cfp.closed? }.from(false).to(true)
    end

    it "saves the record" do
      expect { cfp.close! }.to change { cfp.persisted? }.from(false).to(true)
    end
  end
end
