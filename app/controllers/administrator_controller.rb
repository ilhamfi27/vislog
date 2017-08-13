class AdministratorController < ApplicationController
  before_action :user_not_administrator
  def index; end
end
