class CreateEventsToSpeakersJoinTable < ActiveRecord::Migration
  def up
    create_join_table :events, :speaker_profiles
    Event.all.each do |event|
      event.speakers << event.user.speaker_profile if event.user.speaker_profile.present?
    end
  end

  def down
    drop_table :events_speaker_profiles
  end
end
