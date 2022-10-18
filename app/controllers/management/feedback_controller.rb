module Management
  class FeedbackController < ManagementController
    def index
      @conference = find_conference
    end

    private

    def find_conference
      Conference.eager_load(:feedbacks, :feedbacks_with_comment, :event_feedbacks, :event_feedbacks_with_comment).find(params[:conference_id])
    end
  end
end
