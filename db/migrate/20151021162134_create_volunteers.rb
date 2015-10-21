class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :picture_id
      t.string :email
      t.string :unique_id
      t.string :phone
      t.string :tshirt_size
      t.string :tshirt_cut
      t.string :food_preferences
      t.text :previous_experience
      t.text :notes

      t.timestamps null: false
    end

    add_index :volunteers, :unique_id, unique: true
  end
end
