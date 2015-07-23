class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # rescue_from AuthorsController::Exception, :with => :error_render_method

    # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  # def error_render_method
    # redirect_to root_path
    # respond_to do |type|
      # type.xml { render :template => "errors/error_404", :status => 404 }
      # type.all  { render :nothing => true, :status => 404 }
    # end
    # true
  # end

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
