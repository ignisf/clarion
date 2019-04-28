class RemoveSlugFromConferences < ActiveRecord::Migration[4.2]
  def change
    remove_column :conferences, :slug
  end
end
