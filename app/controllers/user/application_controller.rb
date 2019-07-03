class User::ApplicationController < ActionController::Base
  layout 'user'

  include Pundit
  protect_from_forgery

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def user_not_authorized
    if request.xhr?
      render json: { error: 'you are not authorized' }, status: :unauthorized
    else
      flash.alert = 'you are not authorized'
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
