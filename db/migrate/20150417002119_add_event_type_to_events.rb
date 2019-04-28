class AddEventTypeToEvents < ActiveRecord::Migration[4.2]
  def change
    add_reference :events, :event_type, index: true, foreign_key: true
  end
end
