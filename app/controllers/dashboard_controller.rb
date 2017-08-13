class DashboardController < ApplicationController
  before_action :user_is_administrator
  def index
    @search = TelevisionProgram.search(params[:q])
    @television_programs = @search.result
  end
end
