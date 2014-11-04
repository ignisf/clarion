require 'rails_helper'

RSpec.describe Conference, :type => :model do
  describe 'title' do
    it 'must not be blank' do
      expect(build(:conference, title: '')).to have_error_on :title
    end

    it 'must be unique' do
      create :conference, title: 'ExampleConf'
      expect(build(:conference, title: 'ExampleConf')).to have_error_on :title
    end

    it 'must be translatable' do
      conference = build(:conference)
      expect(conference).to have_translatable :title
    end
  end

  describe 'email' do
    it 'must be present' do
      expect(build(:conference, email: '')).to have_error_on :email
    end

    it 'can contain exatly one @' do
      expect(build(:conference, email: 'test@@example.com')).to have_error_on :email
      expect(build(:conference, email: 'test@example.com')).to_not have_error_on :email
      expect(build(:conference, email: 'testexample.com')).to have_error_on :email
    end
  end

  describe 'description' do
    it 'must be present' do
      expect(build(:conference, description: '')).to have_error_on :description
    end

    it 'must be translatable' do
      expect(build(:conference)).to have_translatable :description
    end
  end

  it 'is invalid without a start date' do
    expect(build(:conference, start_date: nil)).to have_error_on :start_date
  end

  it 'is invalid without an end date' do
    expect(build(:conference, end_date: nil)).to have_error_on :end_date
  end

  it 'is invalid when the end date is before the start date' do
    expect(build(:conference, start_date: '2014-07-29 21:29:13', end_date: '2014-07-28 01:00:00')).to have_error_on :end_date
  end
end
