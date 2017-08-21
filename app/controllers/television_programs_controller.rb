class TelevisionProgramsController < ApplicationController
  before_action :set_channel_collection, only: [:new, :edit]
  before_action :set_television_program, only: [:show, :edit, :update, :destroy]

  def new
    @television_program = TelevisionProgram.new
  end

  def create
    @television_program = TelevisionProgram.new(television_program_params)
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
    redirect_to administrator_path, notice: 'television_program was successfully destroyed.'
  end


  private
    def set_television_program
      @television_program = TelevisionProgram.find(params[:id])
    end

    def set_channel_collection
      @channel_collection = Channel.all.collect {|i| [i.name, i.id] }
    end

    def television_program_params
      params.require(:television_program).permit(:program, :level_1, :level_2, :start_time, :end_time, :duration, :size, :cost, :st_video, :et_video, :channel_id)
    end
end
