class TelevisionProgramPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    
  end

  def destroy?
    
  end

  def import?
    
  end

  def download_video?
    
  end
end