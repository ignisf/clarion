class AddTranslationsToHalls < ActiveRecord::Migration[4.2]
  def self.up
    Hall.create_translation_table!({
      :name => :string
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Hall.drop_translation_table! :migrate_data => true
  end
end
