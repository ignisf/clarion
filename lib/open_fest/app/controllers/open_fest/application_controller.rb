module OpenFest
  class ApplicationController < ActionController::Base
    include ::CurrentConferenceAssigning

    before_filter :require_current_conference!
    before_filter :set_locale

    def set_locale
      if params[:locale]
        I18n.locale = params[:locale]
      end
    end

    def default_url_options(options = {})
      options.merge(locale: params[:locale])
    end
  end
end
