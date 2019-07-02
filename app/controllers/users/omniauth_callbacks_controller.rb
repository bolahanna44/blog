class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :load_user
  def facebook
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_path(email: @user.email, username: @user.username)
    end
  end

  def google_oauth2
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_path(email: @user.email, username: @user.username)
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def load_user
    puts request.env["omniauth.auth"].to_s
    @user = User.from_omniauth(request.env["omniauth.auth"])
  end
end