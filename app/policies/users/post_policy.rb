class Users::PostPolicy < ApplicationPolicy
  def show?
    @record.published?
  end
end
