class AdsPerformancesController < ApplicationController
  before_action :program_search_result, only: [:home, :index]

  def index; end

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
      @search = TelevisionProgram.dashboard_search(params[:keyword], params[:cols])
      @television_programs = @search.result
    end
end
