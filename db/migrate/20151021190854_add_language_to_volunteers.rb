class AddLanguageToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :language, :string
  end
end
