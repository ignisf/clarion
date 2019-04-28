class AddConferenceIdToPersonalProfiles < ActiveRecord::Migration[4.2]
  def change
    add_column :personal_profiles, :conference_id, :integer
    add_index :personal_profiles, :conference_id
  end
end
