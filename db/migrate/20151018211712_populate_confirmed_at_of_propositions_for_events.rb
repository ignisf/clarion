class Event < ActiveRecord::Base
  include Proposable
end

class PopulateConfirmedAtOfPropositionsForEvents < ActiveRecord::Migration
  def up
    Event.all do |event|
      event.proposition.update(confirmed_at: event.confirmed_at)
    end
  end

  def down
    Event.all do |event|
      event.update(confirmed_at: event.proposition.confirmed_at)
    end
  end
end
