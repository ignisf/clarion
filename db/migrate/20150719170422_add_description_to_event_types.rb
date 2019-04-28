class AddDescriptionToEventTypes < ActiveRecord::Migration[4.2]
  def change
    add_column :event_types, :description, :text
  end
end
