class CreateTracks < ActiveRecord::Migration[4.2]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.references :conference, index: true

      t.timestamps
    end
  end
end
