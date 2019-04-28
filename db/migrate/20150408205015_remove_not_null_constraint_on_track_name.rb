class RemoveNotNullConstraintOnTrackName < ActiveRecord::Migration[4.2]
  def change
    change_column :tracks, :name, :text, null: true
  end
end
