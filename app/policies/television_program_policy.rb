class TelevisionProgramPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def import?
    user.admin?
  end

  def download_video?
    user.present?
  end
end