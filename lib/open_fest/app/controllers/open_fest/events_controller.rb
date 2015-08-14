require_dependency "open_fest/application_controller"

module OpenFest
  class EventsController < ApplicationController
    before_filter :authenticate_user!

    def index
    end

    def new
      event_type = current_conference.event_types.find(params[:type])
      @event = Event.new event_type: event_type
    end

    def create
      @event = Event.new event_params
      @event.conference = current_conference
      @event.build_proposition proposer: current_user
      @event.participations.build participant: current_user, approved: true

      if @event.save
        redirect_to action: :index
      else
        render action: :new
      end
    end

    private

    def event_params
      params.require(:event).permit(
        :title, :subtitle, :track_id, :length, :language,
        :abstract, :description, :notes, :agreement,
        :event_type_id
      )
    end
  end
end
