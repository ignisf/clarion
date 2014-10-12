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

    def backup
      @suggestion_groups = SuggestionGroup.for_conference Conference.current, state: Event.states[:backup]
      render :index
    end

    def show
    end

    def state
      @suggestion.state = state_params
      @suggestion.save
    end

    def send_acceptance_notifications
      @suggestions = Conference.current.events.approved.where acceptance_notification_sent_at: nil
      if @suggestions.all?(&:send_acceptance_notification!)
        head :no_content
      else
        head :unprocessable_entity
      end
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
