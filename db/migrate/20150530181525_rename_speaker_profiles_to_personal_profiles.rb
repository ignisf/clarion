class RenameSpeakerProfilesToPersonalProfiles < ActiveRecord::Migration
  def change
    rename_table :speaker_profiles, :personal_profiles
  end
end
