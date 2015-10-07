class Api::HallsController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @halls = current_conference.halls
  end
end
