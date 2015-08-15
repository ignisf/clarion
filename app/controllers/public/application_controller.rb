module Public
  class ApplicationController < ::ApplicationController
    include ::CurrentConferenceAssigning
    before_filter :require_current_conference!
  end
end
