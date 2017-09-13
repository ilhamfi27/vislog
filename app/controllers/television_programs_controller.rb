class TelevisionProgramsController < ApplicationController
  before_action :set_channel_collection, only: [:new, :edit]
  before_action :set_television_program, only: [:show, :edit, :update, :destroy]
  before_action :show_all_television_program_data, only: [:index]

  def index
    
  end

  def new
    @television_program = TelevisionProgram.new
    post_buy = @television_program.build_post_buy
    post_buy.build_viewer
  end

  def create
    @television_program = TelevisionProgram.new(television_program_params)
    @television_program.start_time = to_seconds(television_program_params[:start_time])
    @television_program.end_time =  to_seconds(television_program_params[:end_time])
    @television_program.st_video =  to_seconds(television_program_params[:st_video])
    @television_program.et_video =  to_seconds(television_program_params[:et_video])
    @television_program.duration =  @television_program.et_video - @television_program.st_video
    movie = FFMPEG::Movie.new(params[:television_program][:video].path)
    movie.transcode(params[:television_program][:video].path, video_codec: 'libx264')
    # binding.pry
    if @television_program.save
      redirect_to new_television_program_path, notice: 'Program was successfully added.'
    else
      render :new
    end
  end

  def edit
    @television_program = TelevisionProgram.find(set_television_program)
  end

  def update
    if @television_program.update(television_program_params)
      redirect_to edit_television_program_path(set_television_program.id), notice: 'television_program was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @television_program.destroy
    redirect_to administrators_path, notice: 'television_program was successfully destroyed.'
  end
  
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def import
    if TelevisionProgram.import(params[:file]) 
      redirect_to television_programs_path, notice: "Products imported."
    else
      redirect_to television_programs_path, notice: "Products fail to imported."
      @errors = TelevisionProgram.import_errors
      binding.pry
    end
  end
  


  private
    def set_television_program
      @television_program = TelevisionProgram.find(params[:id])
    end
    
    def show_all_television_program_data
      @television_programs = TelevisionProgram.includes(:channel)
    end

    def set_channel_collection
      @channel_collection = Channel.all.collect {|i| [i.name, i.id] }
    end

    def television_program_params
      params.require(:television_program).permit(:program, :level_1, :level_2, :start_time, :end_time, :duration, :size, :cost, :st_video, :et_video, :channel_id, :video, post_buy_attributes: [:sector, :category, :advertiser, :product, :copy, :break_no, :pos_in_break, :break, :spot_type, :size, :t_second_cost, viewer_attributes: [ :market, :activity, :target, :day_part_or_variable, :tVR, :share, :'000s', :index ] ] )
    end
end
