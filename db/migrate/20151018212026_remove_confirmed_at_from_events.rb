class RemoveConfirmedAtFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :confirmed_at, :timestamp
  end
end
