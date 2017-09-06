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
      programs = Channel.joins(:viewers).select('channels.id, channels.name AS channel_name, sum(viewers."000s") AS sum_of_rating').group('television_programs.channel_id, channels.id, channels.name, viewers."000s"')
      @channel_names = programs.map(&:channel_name)
      @channel_ratings = programs.map(&:sum_of_rating)
    end
end
