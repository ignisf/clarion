require "rails_helper"

RSpec.describe EventType, type: :model do
  describe "description" do
    it "must be present" do
      expect(build(:event_type, description: nil)).to have_error_on :description
    end

    it "is translatable" do
      event_type = build(:event_type)
      expect(event_type).to have_translatable :description
    end
  end

  describe "name" do
    it "must be present" do
      expect(build(:event_type, name: nil)).to have_error_on :name
      expect(build(:event_type, name: "")).to have_error_on :name
    end

    it "must be unique for a event_type" do
      conference = create :conference
      create :event_type, name: "foo", conference: conference
      expect(build(:event_type, name: "foo", conference: conference)).to have_error_on :name
      expect(build(:event_type, name: "foo", conference: create(:conference))).to_not have_error_on :name
    end

    it "is translatable" do
      event_type = build(:event_type)
      expect(event_type).to have_translatable :name
    end
  end
end
