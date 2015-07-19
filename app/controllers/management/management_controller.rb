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
      if not @current_conference and params[:conference_id].present?
        @current_conference = Conference.find(params[:conference_id])
      end

      @current_conference
    end
    helper_method :current_conference

    def authorize_user!
      head :forbidden unless current_user.admin?
    end
  end
end
