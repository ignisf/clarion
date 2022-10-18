module Management
  class FeedbackController < ManagementController
    def index
      @conference = find_conference
    end

    private

    def find_conference
      Conference.find(params[:conference_id])
    end
  end
end
