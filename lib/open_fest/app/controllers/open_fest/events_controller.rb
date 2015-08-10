require_dependency "open_fest/application_controller"

module OpenFest
  class EventsController < ApplicationController
    def index
    end

    def new
      @event_type = current_conference.event_types.find(params[:type])
      @event = Event.new(event_type: @event_type)
    end

    def create
      @event = Event.new(event_params)

      if @event.save
        # TODO (2015-08-10) Flash message?
        flash[:notice] = 'Event was successfully created.'
        redirect_to action: :index
      else
        render action: :new
      end
    end

    private

    def event_params
      params.require(:event).permit(
        :title, :subtitle, :length, :language,
        :abstract, :description, :notes, :agreement,
        :event_type_id
      )
    end
  end
end
