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

  describe 'tracks association' do
    let(:conference) { build :conference }
    let(:track) { build :track }

    before do
      conference.save
      track.conference = conference
      track.save
    end

    it 'links the conference to its tracks' do
      expect(conference.tracks).to include track
    end
  end

  describe 'halls association' do
    let(:conference) { build :conference }
    let(:hall) { build :hall }

    before do
      conference.save
      hall.conference = conference
      hall.save
    end

    it 'has many associated halls' do
      expect(conference.halls).to include hall
    end
  end

  it 'accepts nested attributes for tracks' do
    track_attributes = build(:track, conference: nil).attributes
    conference = create :conference
    expect { conference.update tracks_attributes: [track_attributes]}.to change { conference.tracks.count }.by 1
  end

  it 'rejects nested attributes for tracks when they are all blank' do
    conference = create :conference
    expect { conference.update tracks_attributes: [{'name' => '', 'description' => ''}]}.to_not change { conference.tracks.count }
  end

  it 'allows destruction of tracks by nested attributes' do
    conference = create :conference
    track_attributes = create(:track, conference: conference).attributes
    track_attributes['_destroy'] = 1
    expect { conference.update tracks_attributes: [track_attributes]}.to change { conference.tracks.count }.by(-1)
  end

  it 'accepts nested attributes for halls' do
    hall_attributes = build(:hall, conference: nil).attributes
    conference = create :conference
    expect { conference.update halls_attributes: [hall_attributes]}.to change { conference.halls.count }.by 1
  end

  it 'rejects nested attributes for halls when they are all blank' do
    conference = create :conference
    expect { conference.update halls_attributes: [{'name' => '', 'description' => ''}]}.to_not change { conference.halls.count }
  end

  it 'allows destruction of halls by nested attributes' do
    conference = create :conference
    hall_attributes = create(:hall, conference: conference).attributes
    hall_attributes['_destroy'] = 1
    expect { conference.update halls_attributes: [hall_attributes]}.to change { conference.halls.count }.by(-1)
  end
end
