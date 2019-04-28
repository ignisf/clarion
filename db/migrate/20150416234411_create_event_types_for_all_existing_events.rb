class EventType < ActiveRecord::Base
end

class CreateEventTypesForAllExistingEvents < ActiveRecord::Migration[4.2]
  def up
    event_types = execute 'SELECT events.type AS type_name, tracks.conference_id, MIN(events.created_at) AS created_at FROM events
                           INNER JOIN tracks ON tracks.id = events.track_id
                           WHERE events.type IS NOT NULL
                           GROUP BY type_name, tracks.conference_id;'

    event_types.each do |type|
      event_type = EventType.create! conference_id: type['conference_id'], created_at: type['created_at'], updated_at: type['created_at']

      execute "INSERT INTO event_type_translations (event_type_id, locale, created_at, updated_at, name, description)
               VALUES (#{event_type.id}, 'en', '#{event_type.created_at}', '#{event_type.created_at}', '#{type['type_name']}', 'None');"
    end
  end

  def down
  end
end
