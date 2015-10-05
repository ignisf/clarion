class Api::EventsController < Api::ApplicationController
  def index
    @conference = find_conference
    @events = @conference.events.includes(:track)

    render json: @events, include: :track
  end

  private

  def find_conference
    Conference.find params[:conference_id]
  end
end
