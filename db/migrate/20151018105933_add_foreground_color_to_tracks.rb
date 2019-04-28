class AddForegroundColorToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :foreground_color, :string
  end
end
