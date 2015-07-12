module Management
  class HomeController < ManagementController
    def index
    end

    def set_conference
      conference = Conference.find(params[:id])
      redirect_to management_conference_path(conference, current_conference: conference.slug)
    end
  end
end
