class RenamePictureUrlToPictureInSpeakerProfiles < ActiveRecord::Migration
  def change
    rename_column :speaker_profiles, :photo_url, :picture
  end
end
