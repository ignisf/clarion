class Api::SlotsController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @slots = current_conference.slots
  end
end
