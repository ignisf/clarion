module Management
  class EventsController < ManagementController
    def index
      @conference = find_conference
      @filters = filter_params || {}

      @events = EventSearch
                  .new(scope: Event.where(conference: @conference)
                         .eager_load(:participants_with_personal_profiles,
                                     :proposition, :proposer, {track: [:translations]},
                                     {event_type: [:translations]}, :feedbacks)
                         .preload(:conference), filters: params[:filters]).results

      # @events = @conference.events.order(:title).includes(:proposition, :proposer, :track, :event_type)
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

      if @event.update(event_params)
        flash[:notice] = t(".event_successfully_updated")
        redirect_to [:management, @conference, @event]
      else
        render action: "edit"
      end
    end

    def conflicts
      @conference = find_conference
      @event = @conference.events.find(params[:id])
      @conflicts = @event.conflict_counts
    end

    def destroy
      @conference = find_conference
      @event = @conference.events.find(params[:id])
      @event.destroy

      redirect_to action: :index
    end

    private

    def find_conference
      Conference.eager_load({tracks: :translations}, {event_types: :translations}).find(params[:conference_id])
    end

    def filter_params
      params.fetch(:filters, {}).permit(
        :event_type_id,
        :track_id,
        :language,
        :status,
        :confirmed,
        :not_confirmed,
      )
    end

    def event_params
      params.require(:event).permit(
        :title,
        :subtitle,
        :length,
        :language,
        :abstract,
        :description,
        :notes,
        :track_id,
        :event_type_id,
        participations_attributes: [
          :id,
          :participant_id,
          :approved,
          :_destroy,
        ]
      )
    end
  end
end
