class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  attr_accessor :login

  def record_activity(action)
    @activity = ActivityRecord.new
    @activity.username = current_user.username
    @activity.note = action
    @activity.user_ip = request.env['REMOTE_ADDR']
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.controller = controller_name 
    @activity.action = action_name 
    @activity.params = params.inspect
    @activity.save
  end

  def user_has_signed_in
    if user_signed_in?
      redirect_to 
    end
  end

  protected
    def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
     devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :password_confirmation])
     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
    end

  private
    def after_sign_in_path_for(resource)
      home_path
    end
end
