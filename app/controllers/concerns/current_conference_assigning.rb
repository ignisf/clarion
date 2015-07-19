module CurrentConferenceAssigning
  extend ActiveSupport::Concern

  included do
    helper_method :current_conference?
    helper_method :current_conference
  end

  def current_conference?
    current_conference.present?
  end

  def current_conference
    if not @current_conference and params[:conference_id].present?
      @current_conference = Conference.find(params[:conference_id])
    end

    @current_conference
  end

  def require_current_conference!
    if not current_conference?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
