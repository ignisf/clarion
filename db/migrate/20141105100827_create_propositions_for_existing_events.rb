class CreatePropositionsForExistingEvents < ActiveRecord::Migration[4.2]
  def up
    events = execute "SELECT * FROM events"

    events.each do |event|
      execute "INSERT INTO propositions (proposer_id, proposition_accepting_id, proposition_accepting_type, proposable_id, proposable_type, status, created_at, updated_at)
                 VALUES (#{event["user_id"]}, #{event["track_id"]}, 'Track', #{event["id"]}, 'Event', #{event["state"]}, '#{event["created_at"]}', '#{event["updated_at"]}')"
    end
  end

  def down
    event_ids = execute("SELECT * FROM events").map { |event| event["id"] }
    execute "DELETE FROM propositions WHERE proposable_id IN (#{event_ids.join(", ")}) AND proposable_type = 'Event'"
  end
end
