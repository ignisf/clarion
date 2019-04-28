class CreateVolunteerTeams < ActiveRecord::Migration[4.2]
  def up
    create_table :volunteer_teams do |t|
      t.references :conference, index: true, foreign_key: true
      t.string :color

      t.timestamps null: false
    end
    VolunteerTeam.create_translation_table! name: :string, description: :text
  end

  def down
    drop_table :volunteer_teams
    VolunteerTeam.drop_translation_table!
  end
end
