class User::PostPolicy < ApplicationPolicy
  def authenticate?
    @record.user == @user && @record.draft?
  end

  def publish?
    authenticate?
  end
end
