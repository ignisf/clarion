class RemoveSlugFromConferences < ActiveRecord::Migration
  def change
    remove_column :conferences, :slug
  end
end
