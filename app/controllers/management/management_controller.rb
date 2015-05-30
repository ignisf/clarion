module Management
  class ManagementController < ::ApplicationController
    before_action :authenticate_user!, :authorize_user!

    layout 'management'

    private

    def current_conference?
      current_conference.present?
    end
    helper_method :current_conference?

    def current_conference
      @current_conference ||= (session[:current_conference_id] and Conference.find_by(id: session[:current_conference_id]))
    end
    helper_method :current_conference

    def set_current_conference(conference)
      if conference.present?
        session[:current_conference_id] = conference.id
      else
        session.delete(:current_conference_id)
      end
    end

    def authorize_user!
      head :forbidden unless current_user.admin?
    end
  end
end
