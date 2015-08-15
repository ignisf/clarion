module Public
  class EventsController < Public::ApplicationController
    before_filter :authenticate_user!

    def index
    end

    def new
      event_type = current_conference.event_types.find(params[:type])
      @event = Event.new event_type: event_type
    end

    def create
      @event = Event.new event_params
      @event.conference = current_conference
      @event.build_proposition proposer: current_user
      @event.participations.build participant: current_user, approved: true

      if @event.save
        after_save_redirect
      else
        render action: :new
      end
    end

    private

    def event_params
      params.require(:event).permit(
        :title, :subtitle, :track_id, :length, :language,
        :abstract, :description, :notes, :agreement,
        :event_type_id
      )
    end

    def after_save_redirect
      if current_user.personal_profile(current_conference).present?
        redirect_to root_path
      else
        redirect_to edit_personal_profile_path, alert: I18n.t(:please_fill_in_your_speaker_profile)
      end
    end
  end
end
