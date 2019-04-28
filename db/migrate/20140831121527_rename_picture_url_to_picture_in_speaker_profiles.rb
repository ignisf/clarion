class RenamePictureUrlToPictureInSpeakerProfiles < ActiveRecord::Migration[4.2]
  def change
    rename_column :speaker_profiles, :photo_url, :picture
  end
end
