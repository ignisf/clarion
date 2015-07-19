module Management
  # TODO (2015-07-19) Group by user
  class PropositionsController < ManagementController
    def index
      @conference = find_conference
      @proposed_events = Event.undecided
    end

    private

    def find_conference
      Conference.find(params[:conference_id])
    end
  end
end
