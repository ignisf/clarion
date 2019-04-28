class AddDescriptionToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :description, :text
  end
end
