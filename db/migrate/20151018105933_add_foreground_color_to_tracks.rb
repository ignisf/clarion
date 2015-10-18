class AddForegroundColorToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :foreground_color, :string
  end
end
