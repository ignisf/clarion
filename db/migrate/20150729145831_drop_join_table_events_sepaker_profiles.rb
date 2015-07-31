class DropJoinTableEventsSepakerProfiles < ActiveRecord::Migration
  def up
    drop_table :events_speaker_profiles
  end
end
