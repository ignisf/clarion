class Conference < ActiveRecord::Base
end

class PersonalProfile < ActiveRecord::Base
end

class PopulateConferenceIdInPersonalProfiles < ActiveRecord::Migration
  def change
    conference = Conference.first!
    PersonalProfile.where(conference_id: nil).update_all(conference_id: conference.id)
  end
end
