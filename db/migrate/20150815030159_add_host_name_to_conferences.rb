class AddHostNameToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :host_name, :string
    add_index :conferences, :host_name
  end
end
