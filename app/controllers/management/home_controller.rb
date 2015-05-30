module Management
  class HomeController < ManagementController
    def index
    end

    def set_conference
      conference = Conference.find(params[:id])
      set_current_conference(conference)

      redirect_to [:management, conference]
    end
  end
end
