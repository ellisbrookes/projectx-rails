class CompaniesPolicy < ApplicationPolicy
  def index
    user.admin?
  end
end
