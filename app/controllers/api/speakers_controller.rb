class Api::SpeakersController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @speakers = PersonalProfile.joins(user: [:events]).where(conference: current_conference)
  end
end
