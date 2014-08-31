class CreateSpeakerProfiles < ActiveRecord::Migration
  def change
    create_table :speaker_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :organisation
      t.string :public_email
      t.string :photo_url
      t.string :mobile_phone
      t.text :biography
      t.string :github
      t.string :twitter

      t.timestamps
    end
  end
end
