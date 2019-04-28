require "csv"
module Management
  class ManagementController < ::ApplicationController
    before_action :authenticate_user!, :authorize_user!

    layout "management"

    private

    def authorize_user!
      head :forbidden unless current_user.admin?
    end
  end
end
