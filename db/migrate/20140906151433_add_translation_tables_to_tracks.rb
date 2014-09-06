class AddTranslationTablesToTracks < ActiveRecord::Migration
  def up
    Track.create_translation_table!({
                                      name: :string,
                                      description: :text
                                    }, {
                                      migrate_data: true
                                    })
  end

  def down
    Track.drop_translation_table! migrate_data: true
  end
end
