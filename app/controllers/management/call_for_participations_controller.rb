module Management
  class CallForParticipationsController < ManagementController
    def create
      current_conference.call_for_participation.open!
      redirect_back fallback_location: [:management, current_conference]
    end

    def destroy
      current_conference.call_for_participation.close!
      redirect_back fallback_location: [:management, current_conference]
    end
  end
end
