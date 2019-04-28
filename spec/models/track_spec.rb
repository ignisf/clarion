require "rails_helper"

RSpec.describe Track, type: :model do
  it "is invalid without a name" do
    expect(build(:track, name: "")).to have_error_on :name
  end

  describe "color" do
    it "must be present" do
      expect(build(:track, color: "")).to have_error_on :color
    end

    it "must be a hex RGB triplet" do
      expect(build(:track, color: "foobar")).to have_error_on :color
      expect(build(:track, color: "000000")).to_not have_error_on :color
      expect(build(:track, color: "#000000")).to_not have_error_on :color
    end
  end

  it "belongs to a conference" do
    conference = create :conference
    expect(build(:track, conference_id: conference.id).conference).to eq conference
  end
end
