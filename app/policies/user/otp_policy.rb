class User::OtpPolicy < ApplicationPolicy
  def show?
    @record.post.user == @user && @record.post.draft?
  end

  def verify?
    show?
  end

  def send_token?
    show?
  end
end
