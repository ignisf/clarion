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

    # TODO (2015-06-09) Fetch conferences by slug only
    def current_conference
      @current_conference ||=
        begin
          # if params[:current_conference]
          #   Conference.find_by_slug(params[:current_conference])
          # end

          if session[:current_conference_id]
            Conference.find_by(id: session[:current_conference_id])
          end
        end
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
