class DropJoinTableEventsSepakerProfiles < ActiveRecord::Migration[4.2]
  def up
    drop_table :events_speaker_profiles
  end
end
