class User::ApplicationController < ActionController::Base
  layout 'application'

  include Pundit
  protect_from_forgery

  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def policy_scope(scope)
    super([:user, scope])
  end

  def authorize(record, query = nil)
    super([:user, record], query)
  end

  protected

  def user_not_authorized
    if request.xhr?
      render json: { error: 'you are not authorized' }, status: :unauthorized
    else
      flash.alert = 'you are not authorized'
      redirect_to root_path
    end
  end
end
