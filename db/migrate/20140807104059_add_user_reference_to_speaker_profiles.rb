class AddUserReferenceToSpeakerProfiles < ActiveRecord::Migration
  def change
    add_reference :speaker_profiles, :user, index: true
  end
end
