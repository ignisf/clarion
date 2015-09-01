class CreateVolunteerships < ActiveRecord::Migration
  def change
    create_table :volunteerships do |t|
      t.references :volunteer_team, index: true, foreign_key: true
      t.references :volunteer, index: true

      t.timestamps null: false
    end

    add_foreign_key :volunteerships, :users, column: :volunteer_id
  end
end
