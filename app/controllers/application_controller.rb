class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  before_filter :include_gon
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user_create
    return current_user if current_user
    sign_in User.create_trial!
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end

  def include_gon
    root = root_url.split("")[0..-2].join()
    gon.current_user = current_user if current_user
    gon.sign_in = root + user_session_path
    gon.sign_up = root + users_path
    gon.sign_out_path = root + destroy_user_session_path
  end

end
