class AddTimeLimitsToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :minimum_length, :integer
    add_column :event_types, :maximum_length, :integer
  end
end
