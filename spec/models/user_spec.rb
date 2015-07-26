require 'rails_helper'

RSpec.describe User do
  it 'lets Devise handle email and password validations' do
    expect(build(:user)).to be_a Devise::Models::Validatable
  end

  it "can clone a previous profile for use in a different conference" do
    user = create :user
    old_conference = create :conference
    new_conference = create :conference

    old_profile = create :personal_profile, {
      user:       user,
      biography:  "Old profile bio",
      conference: old_conference
    }

    expect(user.personal_profile(old_conference)).to eq old_profile
    expect(user.personal_profile(new_conference)).to be_nil

    new_profile = user.clone_recent_profile(new_conference)
    expect(new_profile.biography).to eq old_profile.biography

    user.reload
    user.personal_profiles << new_profile

    expect(user.personal_profile(old_conference)).to eq old_profile
    expect(user.personal_profile(new_conference)).to eq new_profile
  end
end
