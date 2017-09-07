class AdsPerformancesController < ApplicationController
  before_action :program_search_result, only: [:index]
  before_action :chart_data, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.json { render :json => program_search_result }
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
       format.xlsx {render xlsx: 'export_data',filename: "tables.xlsx"}
    end
  end

  private
    def program_search_result
      @search = TelevisionProgram.dashboard_search(params[:keyword], params[:cols], params[:date])
      @television_programs = @search.result
    end

    def chart_data
      @channel_names = Channel.chart_channel_names # => [GTV, TRANS7, TVONE, NET, ... ]
      @channel_ratings = Channel.chart_sum_of_rating # sum of rating for every channel in array
    end
end
