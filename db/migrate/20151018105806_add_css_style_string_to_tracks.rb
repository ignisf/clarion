class AddCssStyleStringToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :css_style, :text
  end
end
