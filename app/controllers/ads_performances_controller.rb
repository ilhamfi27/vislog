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

  def export_tables

    @tables = [TelevisionProgram, PostBuy, Viewer].map do |model|
      { 
        table_name: model.table_name,
        column_names: model.column_names,
        data: model.all
      }
    end

    respond_to do |format| 
       format.xlsx {render xlsx: 'export_tables',filename: "tables.xlsx"}
    end
    record_activity("Export table")    
  end

  def download_cutted_videos
    time_ranges = params[:time_ranges].values
    television_program = TelevisionProgram.find(params[:television_program_id])
    video_url = television_program.video.url(:mp4)
    tmp_location = Rails.root.to_s + "/tmp/cutted_videos/#{session.id}/"
    concat_list = time_ranges.map.with_index{|x, i| "#{i}.mp4"}.join('|')
    video_url = Rails.root.to_s + '/app/public' + video_url

    FileUtils::mkdir_p tmp_location

    time_ranges.each.with_index do |time_range, index|
      start_time = to_hours(time_range[0].to_i)
      end_time = to_hours(time_range[1].to_i)
      video = FFMPEG::Movie.new(video_url)
      binding.pry
      video.transcode("#{tmp_location}#{index}.mp4", seek_time: start_time, duration: end_time)
    end

    system "ffmpeg -i 'concat:" + concat_list + "' -codec copy #{tmp_location}/final.mp4"

    send_file(
      "#{tmp_location}final.mp4",
      filename: "bla.mp4",
      type: "video/mp4"
    )    
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
