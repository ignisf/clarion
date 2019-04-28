class AddCssStyleStringToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :css_style, :text
  end
end
