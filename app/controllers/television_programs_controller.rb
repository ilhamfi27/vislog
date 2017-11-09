class TelevisionProgramsController < ApplicationController
  before_action :set_channel_collection, only: [:new, :edit]
  before_action :set_television_program, only: [:show, :edit, :update, :destroy, :download_video]
  before_action :show_all_television_program_data, only: [:index]
  before_action :count_has_not_read_notifications, only: [:index]
  before_action :has_not_read_notifications, only: [:index]

  def index; end

  def new
    @television_program = TelevisionProgram.new
    post_buy = @television_program.build_post_buy
    post_buy.build_viewer
    authorize @television_program
  end

  def create
    @television_program = TelevisionProgram.new(television_program_params)
    @television_program.start_time = to_seconds(television_program_params[:start_time])
    @television_program.end_time =  to_seconds(television_program_params[:end_time])
    @television_program.st_video =  to_seconds(television_program_params[:st_video])
    @television_program.et_video =  to_seconds(television_program_params[:et_video])
    @television_program.duration =  @television_program.et_video - @television_program.st_video
    authorize @television_program
    if @television_program.save
      redirect_to new_television_program_path, notice: 'Program was successfully added.'
    else
      render :new
    end
  end

  def edit
    @television_program = TelevisionProgram.find(set_television_program)
    authorize @television_program
  end

  def update
    if @television_program.update(television_program_params)
    authorize @television_program
      redirect_to edit_television_program_path(set_television_program.id), notice: 'television_program was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @television_program.destroy
    authorize @television_program
    redirect_to administrators_path, notice: 'television_program was successfully destroyed.'
  end
  
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def import
    @importer = TelevisionProgramSpreadsheetImporter.new(params[:file]) 
    # authorize @television_program
    @importer.import!

    # if @importer.is_valid
    #   render :import
    # else
    #   render :import_error
    # end
    
    if @importer
      redirect_to television_programs_path
    end
  end

  def download_video
    respond_to do |format|
      format.js
    end
  end
  
  def clear_all_notifications
    Notification.first.destroy
    redirect_to television_programs_path
  end

  private
    def count_has_not_read_notifications
      @count_has_not_read_notifications = Notification.count_has_not_read_notifications
    end

    def has_not_read_notifications
      @has_not_read_notifications = Notification.has_not_read_notifications
    end

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
