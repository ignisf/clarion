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

  it 'is invalid without a mobile phone' do
    expect(build(:speaker_profile, mobile_phone: nil)).to have_error_on :mobile_phone
  end

  it 'is invalid without a bio' do
    expect(build(:speaker_profile, biography: nil)).to have_error_on :biography
  end
end
