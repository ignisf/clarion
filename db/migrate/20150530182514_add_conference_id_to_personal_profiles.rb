class AddConferenceIdToPersonalProfiles < ActiveRecord::Migration
  def change
    add_column :personal_profiles, :conference_id, :integer
    add_index :personal_profiles, :conference_id
  end
end
