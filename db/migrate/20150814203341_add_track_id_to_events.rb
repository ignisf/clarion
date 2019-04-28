class Event < ActiveRecord::Base
  has_one :proposition, as: :proposable
end

class Proposition < ActiveRecord::Base
  belongs_to :proposable, polymorphic: true
end

class AddTrackIdToEvents < ActiveRecord::Migration[4.2]
  def up
    add_reference :events, :track, index: true, foreign_key: true

    Event.all.includes(:proposition).each do |event|
      event.update!(track_id: event.proposition.proposition_accepting_id)
    end
  end

  def down
    remove_reference :events, :track, index: true, foreign_key: true
  end
end
