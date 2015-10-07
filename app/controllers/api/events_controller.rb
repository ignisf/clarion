class Api::EventsController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @events = current_conference.events.includes(:participations)
  end
end
