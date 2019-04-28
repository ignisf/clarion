class AddCssClassToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :css_class, :string
  end
end
