class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password, speaker_profile_attributes: [:first_name, :last_name, :public_email, :organisation, :github, :twitter, :mobile_phone, :biography, :picture, :id])
    end
  end
end
