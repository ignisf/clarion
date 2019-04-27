class Api::SpeakersController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  include ::PublicApiExposing
  before_action :require_current_conference!

  def index
    @speakers = PersonalProfile.joins(user: {participations: {event: :proposition}}).where(events: {id: current_conference.approved_events.pluck(:id)}, conference: current_conference).distinct
  end
end
