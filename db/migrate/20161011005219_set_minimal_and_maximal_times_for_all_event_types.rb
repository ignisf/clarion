class EventType < ActiveRecord::Base
end

class SetMinimalAndMaximalTimesForAllEventTypes < ActiveRecord::Migration
  def up
    EventType.where(minimum_length: nil).update_all(minimum_length: 0)
    EventType.where(maximum_length: nil).update_all(maximum_length: 240)
  end

  def down
  end
end
