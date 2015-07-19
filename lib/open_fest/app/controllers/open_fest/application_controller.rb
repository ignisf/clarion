module OpenFest
  class ApplicationController < ActionController::Base
    include ::CurrentConferenceAssigning

    before_filter :require_current_conference!
  end
end
