class RemoveSpeakerProfileColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :organisation, :string
    remove_column :users, :hide_email, :boolean
    remove_column :users, :photo_url, :string
    remove_column :users, :mobile_phone, :string
    remove_column :users, :biography, :text
    remove_column :users, :github, :string
    remove_column :users, :twitter, :string
  end
end
