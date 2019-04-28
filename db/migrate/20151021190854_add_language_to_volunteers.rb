class AddLanguageToVolunteers < ActiveRecord::Migration[4.2]
  def change
    add_column :volunteers, :language, :string
  end
end
