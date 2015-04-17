class CreateEventTypesForAllExistingEvents < ActiveRecord::Migration
  def up
    event_types = execute 'SELECT DISTINCT(events.type) as type_name, tracks.conference_id, events.created_at, events.updated_at FROM events INNER JOIN tracks ON tracks.id = events.track_id WHERE events.type NOT NULL GROUP BY type_name;'

    event_types.each do |type|
      execute "INSERT INTO event_types (conference_id, created_at, updated_at)
               VALUES (#{type['conference_id']}, '#{type['created_at']}', '#{type['updated_at']}');"

      event_type_id = execute('SELECT MAX(id) AS last_id FROM event_types;').first['last_id']

      execute "INSERT INTO event_type_translations (event_type_id, locale, created_at, updated_at, name, description)
               VALUES (#{event_type_id}, 'en', '#{type['created_at']}', '#{type['created_at']}', '#{type['type_name']}', 'None');"
    end
  end

  def down
  end
end
