module OpenFest::Users::DeviseController
  extend ActiveSupport::Concern

  included do
    before_filter :require_current_conference!
    layout 'open_fest/application'
  end
end
