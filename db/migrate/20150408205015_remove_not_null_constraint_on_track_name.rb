class RemoveNotNullConstraintOnTrackName < ActiveRecord::Migration
  def change
    change_column :tracks, :name, :text, null: true
  end
end
