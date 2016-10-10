module Management
  class ConferencesController < ManagementController
    def new
      @conference = Conference.new
      @conference.event_types.build(name: 'Event type 1')
      @conference.tracks.build(name: 'Track 1')
      @conference.halls.build(name: 'Hall 1')
      @conference.volunteer_teams.build(name: 'Volunteer Team 1')
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

    def update_vote_data
      @conference = find_conference

      begin
        if @conference.update_vote_data!
          flash[:notice] = t('.vote_data_successfully_updated')
        else
          flash[:alert] = t('.error_during_vote_data_save')
        end
        redirect_to :back
      rescue StandardError => e
        flash[:alert] = t('.error_during_connection_with_voting_endpoint', error: e.message)
        render :vote_results
      end
    end

    def vote_results
      @conference = find_conference
    end

    private

    def find_conference
      Conference.find(params[:id])
    end

    def conference_params
      params.require(:conference).permit(
        :title, :email, :start_date, :end_date, :description, :host_name,
        :planned_cfp_end_date, :vote_data_endpoint,
        event_types_attributes: [:id, :name, :description, :maximum_length,
                                 :minimum_length, :_destroy],
        tracks_attributes: [:id, :name, :color, :css_class, :description,
                            :css_style, :foreground_color, :_destroy],
        halls_attributes: [:id, :name, :_destroy],
        volunteer_teams_attributes: [:id, :name, :description, :color, :_destroy]
      )
    end
  end
end
