class RemoveUnneededColumnsFromEvents < ActiveRecord::Migration[4.2]
  def change
    remove_index :events, name: :index_events_on_track_id, column: :track_id
    remove_index :events, name: :index_events_on_type, column: :type
    remove_index :events, name: :index_events_on_user_id, column: :user_id

    remove_column :events, :type, :string
    remove_column :events, :state, :string
    remove_column :events, :track_id, :integer
    remove_column :events, :user_id, :integer
  end
end
