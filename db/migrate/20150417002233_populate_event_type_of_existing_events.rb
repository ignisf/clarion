class PopulateEventTypeOfExistingEvents < ActiveRecord::Migration[4.2]
  def up
    event_ids = execute('SELECT id FROM events WHERE type IS NOT NULL;').map { |row| row['id'] };

    event_ids.each do |id|
      event_type_id = execute("SELECT ett.event_type_id FROM events JOIN event_type_translations AS ett ON events.type = ett.name WHERE events.id = #{id};").first['event_type_id']
      execute("UPDATE events SET event_type_id = #{event_type_id} WHERE id = #{id}");
    end
  end

  def down
    execute("UPDATE events SET event_type_id = NULL");
  end
end
