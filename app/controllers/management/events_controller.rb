module Management
  class EventsController < ManagementController
    before_action :assign_suggestion, only: [:show, :state]

    def index
      @suggestion_groups = SuggestionGroup.for_conference Conference.current
    end

    def approved
      @suggestion_groups = SuggestionGroup.for_conference Conference.current, state: Event.states[:approved]
      render :index
    end

    def undecided
      @suggestion_groups = SuggestionGroup.for_conference Conference.current, state: Event.states[:undecided]
      render :index
    end

    def rejected
      @suggestion_groups = SuggestionGroup.for_conference Conference.current, state: Event.states[:rejected]
      render :index
    end

    def show
    end

    def state
      @suggestion.state = state_params
      @suggestion.save
    end

    private

    def state_params
      params.require :state
    end

    def assign_suggestion
      @suggestion = Event.find params[:id]
    end
  end
end
