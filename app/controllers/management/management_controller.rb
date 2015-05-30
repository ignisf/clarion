module Management
  class ManagementController < ::ApplicationController
    before_action :authenticate_user!, :authorize_user!

    layout 'management'

    private

    def current_conference?
      session[:current_conference_id] and current_conference.present?
    end
    helper_method :current_conference?

    def current_conference
      @current_conference ||= Conference.find(session[:current_conference_id])
    end
    helper_method :current_conference

    def set_current_conference(conference)
      session[:current_conference_id] = conference.id
    end

    def authorize_user!
      head :forbidden unless current_user.admin?
    end
  end
end
