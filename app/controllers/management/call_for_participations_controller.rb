module Management
  class CallForParticipationsController < ManagementController
    def create
      current_conference.call_for_participation.open!
      redirect_to :back
    end

    def destroy
      current_conference.call_for_participation.close!
      redirect_to :back
    end
  end
end
