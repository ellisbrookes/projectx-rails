class CompaniesPolicy < ApplicationPolicy
  def index
    user.user?
  end
  def destroy?
    user.role == 'admin' || record.user == user
  end
end
