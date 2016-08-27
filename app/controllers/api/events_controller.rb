class Api::EventsController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @events = current_conference.events.approved.joins(:proposition).includes(:participations)
  end

  def halfnarp_friendly
    @events = current_conference.events.includes(:track, :event_type)
    render json: @events, include: [:track, :event_type]
  end
end
