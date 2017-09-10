class DashboardController < ApplicationController
  before_action :program_search_result, only: [:home, :index]
  before_action :data_chart, only: [:home, :index]
  before_action :sum_of_no_of_spot, only: [:index]
  before_action :sum_of_cost, only: [:index]

  def home; end

  def index; end

  private
    def program_search_result
      @search = TelevisionProgram.dashboard_search(params[:keyword], params[:cols], params[:date])
      @television_programs = @search.result
      @for_chart_data = @search.result.chart_data
      @for_no_of_spot = @search.result.select('sum(viewers."000s") AS sum_no_of_spot').group('television_programs.channel_id, viewers."000s"')
      @for_cost = @search.result.select('sum(television_programs.cost) AS cost').group('television_programs.channel_id, television_programs.cost')
    end

    def data_chart
      @channel_names = @for_chart_data.chart_channel_names # => [GTV, TRANS7, TVONE, NET, ... ]
      @channel_ratings = @for_chart_data.chart_sum_of_rating # sum of rating for every channel in array
    end

    def sum_of_no_of_spot
      @no_of_spot_total = @for_no_of_spot.map(&:sum_no_of_spot).inject { |sum, n| sum + n } || 0
    end

    def sum_of_cost
      @cost_total = @for_cost.map(&:cost).inject { |sum, n| sum + n } || 0
    end
end
