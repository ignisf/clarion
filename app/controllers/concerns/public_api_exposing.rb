require 'active_support/concern'

module PublicApiExposing
  extend ActiveSupport::Concern

  included do
    before_action :set_access_control_headers
  end
end
