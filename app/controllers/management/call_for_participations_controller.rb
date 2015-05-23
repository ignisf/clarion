module Management
  class CallForParticipationsController < ManagementController
    before_action :assign_conference

    def create
      @conference.call_for_participation.open!
      render :redraw
    end

    def destroy
      @conference.call_for_participation.close!
      render :redraw
    end

    private

    def assign_conference
      @conference = Conference.find params[:conference_id]
    end
  end
end
