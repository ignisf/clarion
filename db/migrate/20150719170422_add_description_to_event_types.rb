class AddDescriptionToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :description, :text
  end
end
