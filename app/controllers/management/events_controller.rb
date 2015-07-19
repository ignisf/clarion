module Management
  class EventsController < ManagementController
    def index
      @conference = find_conference
      # TODO (2015-07-14) Scoped by conference? Why no conference_id
      @events = Event.approved
    end

    def show
      @conference = find_conference
      @event = Event.find(params[:id])
    end

    def edit
      @conference = find_conference
      @event = Event.find(params[:id])
    end

    def update
      @conference = find_conference
      @event = Event.find(params[:id])

      if @event.update_attributes(event_params)
        flash[:notice] = 'Event was successfully updated.'
        redirect_to [:management, @event]
      else
        render action: 'edit'
      end
    end

    def destroy
      @conference = find_conference
      @event = Event.find(params[:id])
      @event.destroy

      redirect_to action: :index
    end

    private

    def find_conference
      Conference.find(params[:conference_id])
    end

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
