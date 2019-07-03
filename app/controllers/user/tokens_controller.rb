class User::TokensController < User::ApplicationController
  def create
    authy_id = Authentication.send_token(params[:mobile],
                                         current_user.email,
                                         params[:force_sms])
    render json: { authy_id: authy_id }
  rescue Authentication::AuthyError => e
    render json: {
      error: "following problem happened while sending token: #{e.message}"
    }, status: :bad_request
  end
end
