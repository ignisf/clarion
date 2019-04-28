class AddUserReferenceToSpeakerProfiles < ActiveRecord::Migration[4.2]
  def change
    add_reference :speaker_profiles, :user, index: true
  end
end
