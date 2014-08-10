class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :title, null: false
      t.string :email, null: false
      t.text :description, null: false
      t.timestamp :start_date, null: false
      t.timestamp :end_date, null: false

      t.timestamps
    end
  end
end
