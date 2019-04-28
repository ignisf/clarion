class Participation   < ActiveRecord::Base; end
class PersonalProfile < ActiveRecord::Base; end

class CreateParticipationRecords < ActiveRecord::Migration[4.2]
  def up
    event_to_speaker_profiles = execute "SELECT * FROM events_speaker_profiles"

    event_to_speaker_profiles.each do |event_to_speaker_profile|
      profile = PersonalProfile.find_by(id: event_to_speaker_profile["speaker_profile_id"])
      next unless profile

      Participation.create! event_id: event_to_speaker_profile["event_id"],
                            participant_id: profile.user_id,
                            approved: true
    end
  end

  def down
    Participation.destroy_all
  end
end
