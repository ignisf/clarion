module Management
  class CallForParticipationsController < ManagementController
    def create
      current_conference.call_for_participation.open!
      render :redraw
    end

    def destroy
      current_conference.call_for_participation.close!
      render :redraw
    end
  end
end
