class User::PostPolicy < ApplicationPolicy
  def show?
    @record.user == @user
  end
end