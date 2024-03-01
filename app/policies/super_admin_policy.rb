class SuperAdminPolicy < ApplicationPolicy
  def index?
    user.has_role?(:superadmin)
  end
end
