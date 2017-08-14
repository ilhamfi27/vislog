class DashboardController < ApplicationController
  before_action :program_search_result, only: [:home, :index]

  def home; end

  def index; end

  private
    def program_search_result
      @search = TelevisionProgram.search(params[:q])
      @television_programs = @search.result
    end
end
