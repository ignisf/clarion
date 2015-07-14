module Management
  class EventsController < ManagementController
    before_action :require_current_conference

    def index
      # TODO (2015-07-14) Scoped by conference? Why no conference_id
      @events = Event.all
    end

    def show
      @event = Event.find(params[:id])
    end

    def edit
      @event = Event.find(params[:id])
    end

    def update
      @event = Event.find(params[:id])

      if @event.update_attributes(event_params)
        flash[:notice] = 'Event was successfully updated.'
        redirect_to [:management, @event]
      else
        render action: 'edit'
      end
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy

      redirect_to action: :index
    end

    private

    def event_params
      params.require(:event).permit(
        :title,
        :subtitle,
        :length,
        :language,
        :abstract,
        :description,
        :notes
      )
    end
  end
end
