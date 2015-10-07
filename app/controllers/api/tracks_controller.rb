class Api::TracksController < Api::ApplicationController
  include ::CurrentConferenceAssigning
  before_filter :require_current_conference!

  def index
    @tracks = current_conference.tracks.includes(:translations)
  end
end
