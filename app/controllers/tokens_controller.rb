class TokensController < ApplicationController
  def create
    authy_id = Authentication.send_token(params[:mobile], current_user.email)
    render json: { authy_id: authy_id }
  rescue Authentication::AuthyError => e
    render json: {
      error: "following problem happened while authenticating your mobile: #{e.message}"
    }, status: :bad_request
  end
end
