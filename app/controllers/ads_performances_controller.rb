class AdsPerformancesController < ApplicationController
  before_action :program_search_result, only: [:home, :index]

  def index; end

  private
    def program_search_result
      @search = TelevisionProgram.dashboard_search(params[:keyword], params[:cols])
      @television_programs = @search.result
    end
end
