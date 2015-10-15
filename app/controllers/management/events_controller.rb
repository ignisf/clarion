module Management
  class EventsController < ManagementController
    def index
      @conference = find_conference
      @events = @conference.events.order(:title)
    end

    def show
      @conference = find_conference
      @event = @conference.events.find(params[:id])
    end

    def edit
      @conference = find_conference
      @event = @conference.events.find(params[:id])
    end

    def update
      @conference = find_conference
      @event = @conference.events.find(params[:id])

      if @event.update_attributes(event_params)
        flash[:notice] = 'Event was successfully updated.'
        redirect_to [:management, @event]
      else
        render action: 'edit'
      end
    end

    def destroy
      @conference = find_conference
      @event = @conference.events.find(params[:id])
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
