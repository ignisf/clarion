module Management
  class ManagementController < ::ApplicationController
    before_action :authenticate_user!, :authorize_user!

    layout 'management'

    private

    def default_url_options(options = {})
      { current_conference: current_conference.try(:slug) }.merge(options)
    end

    def current_conference?
      current_conference.present?
    end
    helper_method :current_conference?

    def current_conference
      @current_conference ||=
        begin
          if params[:current_conference]
            Conference.find_by_slug(params[:current_conference])
          end
        end
    end
    helper_method :current_conference

    def authorize_user!
      head :forbidden unless current_user.admin?
    end
  end
end
