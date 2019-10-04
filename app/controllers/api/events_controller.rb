class Api::EventsController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  include ::PublicApiExposing
  before_action :require_current_conference!

  def index
    @events = current_conference.events.approved.joins(:proposition).includes(:participations)
  end

  def halfnarp_friendly
    @events = current_conference.events.joins(:proposition).includes(:track, :event_type).where.not(propositions: {status: :rejected})
    render json: @events, include: [:track, :event_type]
  end
end
