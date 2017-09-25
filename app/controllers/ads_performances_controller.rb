class AdsPerformancesController < ApplicationController
  before_action :program_search_result, only: [:index]
  before_action :data_chart, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def export_data
    @tables = [TelevisionProgram, PostBuy, Viewer].map do |model|
      { 
        table_name: model.table_name,
        column_names: model.column_names,
        data: model.all
      }
    end

    respond_to do |format| 
      format.xlsx { render xlsx: 'export_data', filename: "vislog-export-tables.xlsx" }
    end
    record_activity("Export table")
  end

  private
    def program_search_result
      @search = TelevisionProgram.dashboard_search(params[:keyword], params[:cols], params[:date])
      @television_programs = @search.result.includes(:channel)
      @for_chart_data = @search.result.chart_data
    end

    def data_chart
      @channel_names = @for_chart_data.chart_channel_names # => [GTV, TRANS7, TVONE, NET, ... ]
      @channel_ratings = @for_chart_data.chart_sum_of_rating # sum of rating for every channel in array
    end
end
