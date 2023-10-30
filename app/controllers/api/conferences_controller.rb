class Api::ConferencesController < Api::ApplicationController
  include ::PublicApiExposing

  def index
    @conferences = Conference.all
  end
end
