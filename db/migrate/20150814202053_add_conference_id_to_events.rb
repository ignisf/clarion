class Event < ActiveRecord::Base
  has_one :proposition, as: :proposable
end

class Proposition < ActiveRecord::Base
  belongs_to :proposable, polymorphic: true
  belongs_to :proposition_accepting, polymorphic: true
end

class Track < ActiveRecord::Base
end

class AddConferenceIdToEvents < ActiveRecord::Migration
  def up
    add_reference :events, :conference, index: true, foreign_key: true

    Event.all.includes(:proposition).each do |event|
      event.update!(conference_id: event.proposition.proposition_accepting.conference_id)
    end
  end

  def down
    remove_reference :events, :conference, index: true, foreign_key: true
  end
end
