module Management
  class EventsController < ManagementController
    before_action :assign_suggestion, only: [:show]

    def index
      @suggestion_groups = SuggestionGroup.for_conference Conference.current
    end

    def show
    end

    private

    def assign_suggestion
      @suggestion = Event.find params[:id]
    end
  end
end
