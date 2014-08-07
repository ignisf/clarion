require 'rails_helper'

RSpec.describe SpeakerProfile, :type => :model do
  it 'is invalid without a first name' do
    expect(build(:speaker_profile, first_name: nil)).to have_error_on :first_name
  end

  it 'is invalid without a last name' do
    expect(build(:speaker_profile, last_name: nil)).to have_error_on :last_name
  end

  it 'is invalid without a photo' do
    expect(build(:speaker_profile, photo_url: nil)).to have_error_on :photo_url
  end

  describe 'mobile_phone' do
    it 'must be present' do
      expect(build(:speaker_profile, mobile_phone: nil)).to have_error_on :mobile_phone
    end

    it 'must be a valid phone number' do
      expect(build(:speaker_profile, mobile_phone: 'abc')).to have_error_on :mobile_phone
    end

    it 'is stored in a normalized form' do
      speaker_profile = create :speaker_profile, mobile_phone: '0883444555'
      expect(speaker_profile.mobile_phone).to eq '359883444555'

      speaker_profile.mobile_phone = '+1883444555'
      speaker_profile.save
      expect(speaker_profile.mobile_phone).to eq '1883444555'
    end
  end

  it 'is invalid without a bio' do
    expect(build(:speaker_profile, biography: nil)).to have_error_on :biography
  end
end
