module Management
  class PropositionsController < ManagementController
    def index
      @conference = find_conference
      @events_by_proposer = @conference.events.undecided.group_by(&:proposer)
    end

    def update
      @proposition = Proposition.find(params[:id])

      @proposition.update(proposition_params)

      redirect_back fallback_location: [:management, current_conference, @proposition]
    end

    private

    def proposition_params
      params.require(:proposition).permit(:status)
    end

    def find_conference
      Conference.find(params[:conference_id])
    end
  end
end
