class Api::TracksController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  include ::PublicApiExposing
  before_action :require_current_conference!

  def index
    @tracks = current_conference.tracks.includes(:translations)
  end
end
