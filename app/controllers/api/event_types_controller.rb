class Api::EventTypesController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @event_types = current_conference.event_types.includes(:translations)
  end
end
