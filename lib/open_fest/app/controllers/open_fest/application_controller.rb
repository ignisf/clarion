module OpenFest
  class ApplicationController < ActionController::Base
    before_action :set_current_conference

    private

    #TODO: Make this display a nice 404 message when the conference is not found
    def set_current_conference
      @current_conference ||= Conference.find(1)
    end
  end
end
