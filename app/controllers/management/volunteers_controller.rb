module Management
  class VolunteersController < ManagementController
    include CurrentConferenceAssigning

    def index
      @filters = params[:filters] || {}
      @volunteers = VolunteerSearch.new(scope: Volunteer.where(conference: current_conference).eager_load(:volunteer_teams), filters: params[:filters]).results
    end

    def show
      @volunteer = current_conference.volunteers.find(params[:id])
    end

    def edit
      @volunteer = current_conference.volunteers.find(params[:id])
    end

    def update
      @volunteer = current_conference.volunteers.find(params[:id])

      if @volunteer.update volunteer_params
        redirect_to management_conference_volunteer_path(@volunteer, conference_id: current_conference.id)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private
    def volunteer_params
      params.require(:volunteer).permit(:name, :picture, :email, :phone,
                                        :tshirt_size, :tshirt_cut,
                                        :food_preferences, :previous_experience,
                                        :notes, :language,
                                        volunteer_team_ids: [])
    end
  end
end
