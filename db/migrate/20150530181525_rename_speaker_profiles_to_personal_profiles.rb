class RenameSpeakerProfilesToPersonalProfiles < ActiveRecord::Migration[4.2]
  def change
    rename_table :speaker_profiles, :personal_profiles
  end
end
