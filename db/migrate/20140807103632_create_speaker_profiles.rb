class CreateSpeakerProfiles < ActiveRecord::Migration
  def change
    create_table :speaker_profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :organisation
      t.string :public_email
      t.string :photo_url, null: false
      t.string :mobile_phone, null: false
      t.text :biography, null: false
      t.string :github, null: false
      t.string :twitter, null: false

      t.timestamps
    end
  end
end
