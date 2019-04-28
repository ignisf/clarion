class AddSlugToConferences < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :slug, :string
    add_index :conferences, :slug
  end
end
