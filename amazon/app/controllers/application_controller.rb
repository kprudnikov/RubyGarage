class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  # puts I18n.locale
  # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected

  #   def configure_permitted_parameters
  #     devise_parameter_sanitizer.for(:sign_up) << :firstname
  #     devise_parameter_sanitizer.for(:sign_up) << :lastname
  #   end

end
