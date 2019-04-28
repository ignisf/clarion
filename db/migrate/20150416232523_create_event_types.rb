class CreateEventTypes < ActiveRecord::Migration[4.2]
  def up
    create_table :event_types do |t|
      t.references :conference, index: true, foreign_key: true

      t.timestamps null: false
    end
    EventType.create_translation_table! name: :string, description: :text
  end

  def down
    drop_table :event_types
    EventType.drop_translation_table!
  end
end
