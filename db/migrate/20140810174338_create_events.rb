class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :subtitle
      t.string :type
      t.integer :length, null: false, default: 45
      t.string :language, null: false, default: "bg_BG"
      t.integer :state
      t.text :abstract, null: false
      t.text :description, null: false
      t.text :notes
      t.references :track, index: true
      t.references :user, index: true

      t.timestamps
    end
    add_index :events, :type
  end
end
