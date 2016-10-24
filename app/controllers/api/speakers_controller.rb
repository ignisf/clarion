class Api::SpeakersController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @speakers = PersonalProfile.joins(user: {participations: {event: :proposition}}).where(events: {id: current_conference.approved_events.pluck(:id)}, conference: current_conference).distinct
  end
end
