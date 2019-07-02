# frozen_string_literal: true
class Users::ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  layout 'users'

  def authorize(record, query = nil)
    super([:users, record], query)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    if request.xhr?
      render json: { error: 'you are not authorized' }, status: :unauthorized
    else
      flash.alert = 'you are not authorized'
      redirect_to root_path
    end
  end

end