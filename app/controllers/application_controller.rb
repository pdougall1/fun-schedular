class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :include_gon

  def include_gon
    root = root_url.split("")[0..-2].join()
    gon.current_user = current_user if current_user
    gon.auth_path = root + user_session_path
    gon.sign_out_path = root + destroy_user_session_path
  end

end
