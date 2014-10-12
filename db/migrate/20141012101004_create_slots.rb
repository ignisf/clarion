class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.references :hall, index: true
      t.timestamp :starts_at, null: false
      t.timestamp :ends_at, null: false
      t.references :event, index: true

      t.timestamps
    end
  end
end
