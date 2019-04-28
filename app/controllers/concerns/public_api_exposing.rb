require "active_support/concern"

module PublicApiExposing
  extend ActiveSupport::Concern

  def set_access_control_headers
    if request.format.json?
      response.headers["Access-Control-Allow-Origin"] = "*"
    end
  end

  included do
    before_action :set_access_control_headers
  end
end
