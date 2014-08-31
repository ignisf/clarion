require 'rails_helper'

RSpec.describe SpeakerProfile, :type => :model do
  it 'is invalid without a first name' do
    expect(build(:speaker_profile, first_name: nil)).to have_error_on :first_name
  end

  it 'is invalid without a last name' do
    expect(build(:speaker_profile, last_name: nil)).to have_error_on :last_name
  end

  it 'is invalid without a picture' do
    expect(build(:speaker_profile, picture: nil)).to have_error_on :picture
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

  describe 'public email' do
    it 'can be absent' do
      expect(build(:speaker_profile, public_email: '')).to_not have_error_on :public_email
    end

    it 'can contain exatly one @ when present' do
      expect(build(:speaker_profile, public_email: 'test@@example.com')).to have_error_on :public_email
      expect(build(:speaker_profile, public_email: 'test@example.com')).to_not have_error_on :public_email
      expect(build(:speaker_profile, public_email: 'testexample.com')).to have_error_on :public_email
    end
  end

  describe 'twitter handle' do
    it 'can be absent' do
      expect(build(:speaker_profile, twitter: '')).to_not have_error_on :twitter
    end

    context 'when present' do
      it 'is stored without a starting @' do
        expect(create(:speaker_profile, twitter: '@foobar').twitter).to eq 'foobar'
      end

      it 'must contain only alphanumeric symbols or an underscore' do
        speaker_profile = build :speaker_profile
        speaker_profile.twitter = 'fooBar_1'
        expect(speaker_profile).to_not have_error_on :twitter

        speaker_profile.twitter = 'foobar!'
        expect(speaker_profile).to have_error_on :twitter
      end

      it 'must be maximum 15 symbols long' do
        expect(build(:speaker_profile, twitter: 'a'*16)).to have_error_on :twitter
      end
    end
  end

  describe 'github account' do
    it 'can be absent' do
      expect(build(:speaker_profile, github: '')).to_not have_error_on :twitter
    end

    context 'when present' do
      it 'must contain only alphanumeric symbols or a dash' do
        speaker_profile = build :speaker_profile
        speaker_profile.github = 'fooBar-1'
        expect(speaker_profile).to_not have_error_on :github

        speaker_profile.github = 'foobar!'
        expect(speaker_profile).to have_error_on :github
      end

      it 'must not start with a dash' do
        expect(build(:speaker_profile, github: '-foobar')).to have_error_on :github
      end
    end
  end

  it 'is invalid without a bio' do
    expect(build(:speaker_profile, biography: nil)).to have_error_on :biography
  end
end
