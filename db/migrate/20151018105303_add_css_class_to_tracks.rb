class AddCssClassToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :css_class, :string
  end
end
