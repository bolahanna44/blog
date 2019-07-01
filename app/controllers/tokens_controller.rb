class TokensController < ApplicationController
  def verify
    Authentication.verify_token(params[:authy_id], params[:token])
    head :ok
  rescue Authentication::AuthyError => e
    render json: {
      error: e.message
    }, status: :bad_request
  end

  def send_token
    authy_id = Authentication.send_token(params[:mobile], current_user.email)
    render json: { authy_id: authy_id }
  rescue Authentication::AuthyError => e
    render json: {
      error: "following problem happened when authenticating your mobile: #{e.message}"
    }, status: :bad_request
  end
end
