class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :javascript_exists?
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
      redirect_to home_path
    end
  end

  def javascript_exists?(script)
    extensions = %w(.coffee .erb .coffee.erb) + [""]
    extensions.inject(false) do |truth, extension|
      truth || File.exists?(File.join(Rails.root, 'app', 'assets', 'javascripts', "#{script}.js#{extension}"))
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

    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to request.referrer
    end
end
