module Public
  class EventsController < Public::ApplicationController
    before_filter :authenticate_user!

    def index
      @events = Event.joins(:conference, :proposition, :participations).where(conference: current_conference).where('propositions.proposer_id = ? OR participations.participant_id = ?', current_user.id, current_user.id)
    end

    def edit
      @event = current_user.events.find(params[:id])
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
        flash[:notice] = I18n.t('views.events.event_successfully_created', event_type: @event.event_type.name.mb_chars.downcase)
        after_save_redirect
      else
        render action: :new
      end
    end

    def update
      @event = current_user.events.find(params[:id])

      if @event.update(event_params)
        flash[:notice] = I18n.t('views.events.event_successfully_updated', event_type: @event.event_type.name.mb_chars.downcase)
        after_save_redirect
      else
        render action: :edit
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
        redirect_to events_path
      else
        redirect_to edit_personal_profile_path, alert: I18n.t(:please_fill_in_your_speaker_profile)
      end
    end
  end
end
