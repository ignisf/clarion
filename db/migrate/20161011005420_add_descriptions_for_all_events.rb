class Event < ActiveRecord::Base
end

class AddDescriptionsForAllEvents < ActiveRecord::Migration[4.2]
  def up
    Event.where(description: [nil, ""]).update_all(description: "n/a")
  end

  def down
  end
end
