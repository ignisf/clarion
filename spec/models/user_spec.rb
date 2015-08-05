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

  describe '#find_or_initialize_personal_profile' do
    context 'when the user has a personal profile for the specified conference' do
      it 'returns the existing personal profile' do
        user = create :user
        conference = create :conference
        personal_profile = create :personal_profile, user: user, conference: conference

        expect(user.find_or_initialize_personal_profile(conference)).to eq personal_profile
      end
    end

    context 'when the user has a personal profile for a previous conference' do
      it 'returns a duplicate of the old profile' do
        user = create :user
        old_conference = create :conference
        conference = create :conference
        personal_profile = create :personal_profile, user: user, conference: old_conference

        expect(user.find_or_initialize_personal_profile(conference).public_email).to be_present
        expect(user.find_or_initialize_personal_profile(conference).public_email).to eq personal_profile.public_email
        expect(user.find_or_initialize_personal_profile(conference)).to be_new_record
      end
    end

    context 'when the user has no personal profiles' do
      it 'returns a new personal profile' do
        user = create :user
        conference = create :conference

        expect(user.find_or_initialize_personal_profile(conference)).to be_new_record
        expect(user.find_or_initialize_personal_profile(conference).conference).to eq conference
      end
    end
  end
end
