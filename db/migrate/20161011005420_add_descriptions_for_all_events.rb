class Event < ActiveRecord::Base
end

class AddDescriptionsForAllEvents < ActiveRecord::Migration
  def up
    Event.where(description: [nil, '']).update_all(description: 'n/a')
  end

  def down
  end
end
