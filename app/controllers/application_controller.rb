class ApplicationController < ActionController::Base
  include CurrentConferenceAssigning

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_view_paths

  # TODO: make this get the domain from the database
  #layout Proc.new { |controller| controller.request.host }
  layout 'public/application'


  def self.default_url_options(options={})
    if I18n.locale != I18n.default_locale
      options.merge({locale: I18n.locale})
    else
      options
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_view_paths
    # TODO: make this get the domain from the database
    prepend_view_path 'lib/initfest/views' if request.host =~ /openfest/
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit :email, :password, :password_confirmation, :current_password, :language
    end
  end
end
