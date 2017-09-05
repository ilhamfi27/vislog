class AdsPerformancesController < ApplicationController
  before_action :program_search_result, only: [:home, :index]

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
      TelevisionProgram.all.includes(post_buy: [:viewer]).group(:channel).count
      TelevisionProgram.all.includes(:channel, post_buy: [:viewer]).group(:channel).count
    end
end
