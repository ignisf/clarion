module OpenFest::Users::DeviseController
  extend ActiveSupport::Concern

  included do
    before_filter :require_current_conference!
    layout 'open_fest/application'
  end

  def signed_in_root_path(user)
    root_path
  end
end
