module Management
  class PropositionsController < ManagementController
    def index
      @conference = find_conference
      @events_by_proposer = @conference.events.undecided.group_by(&:proposer)
    end

    private

    def find_conference
      Conference.find(params[:conference_id])
    end
  end
end
