class ManageUsersPolicy < BasePolicy
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  private

  def admin?
    current_user&.admin?
  end

end
