class Api::EventsController < Api::ApplicationController
  def index
    @conference = find_conference
    @events = @conference.events.includes(:track, :event_type)

    render json: @events, include: [:track, :event_type]
  end

  private

  def find_conference
    Conference.find params[:conference_id]
  end
end
