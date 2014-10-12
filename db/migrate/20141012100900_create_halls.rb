class CreateHalls < ActiveRecord::Migration
  def change
    create_table :halls do |t|
      t.references :conference, index: true
      t.string :name

      t.timestamps
    end
  end
end
