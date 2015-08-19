module Management
  class ConferencesController < ManagementController
    def new
      @conference = Conference.new
      @conference.event_types.build(name: 'Event type 1')
      @conference.tracks.build(name: 'Track 1')
      @conference.halls.build(name: 'Hall 1')
    end

    def create
      @conference = Conference.new(conference_params)

      if @conference.save
        redirect_to [:management, @conference]
      else
        render :new
      end
    end

    def update
      @conference = find_conference
      @conference.update(conference_params)
      @conference.save
      render :edit
    end

    def edit
      @conference = find_conference
    end

    def index
      @conferences = Conference.all.order(start_date: :desc)
    end

    def show
      @conference = find_conference
    end

    def destroy
      @conference = find_conference
      @conference.destroy

      redirect_to management_root_path(current_conference: nil)
    end

    private

    def find_conference
      Conference.find(params[:id])
    end

    def conference_params
      params.require(:conference).permit(
        :title, :email, :start_date, :end_date, :description, :host_name,
        event_types_attributes: [:id, :name, :description, :maximum_length,
                                 :minimum_length, :_destroy],
        tracks_attributes: [:id, :name, :color, :description, :_destroy],
        halls_attributes: [:id, :name, :_destroy]
      )
    end
  end
end
