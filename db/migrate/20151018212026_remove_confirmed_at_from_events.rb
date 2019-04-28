class RemoveConfirmedAtFromEvents < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :confirmed_at, :timestamp
  end
end
