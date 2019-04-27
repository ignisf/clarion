module Public
  class ApplicationController < ::ApplicationController
    include ::CurrentConferenceAssigning
    before_action :require_current_conference!

    def current_conference
      @current_conference ||= Conference.order(created_at: :desc).find_by(host_name: request.host)
    end
  end
end
