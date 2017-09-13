class ViewersController < ApplicationController
  before_action :set_channel_collection, only: [:new, :edit]
  before_action :set_post_buy_collection, only: [:new, :edit]
  before_action :set_viewer, only: [:show, :edit, :update, :destroy]

  def new
    @viewer = Viewer.new
  end

  def create
    @viewer = Viewer.new(viewer_params)
    if @viewer.save
      redirect_to new_viewer_path, notice: 'Program was successfully added.'
    else
      render :new
    end
  end

  def edit
    @viewer = Viewer.find(set_viewer)
  end

  def update
    if @viewer.update(viewer_params)
      redirect_to edit_viewer_path(set_viewer.id), notice: 'viewer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @viewer.destroy
    redirect_to administrators_path, notice: 'viewer was successfully destroyed.'
  end


  private
    def set_viewer
      @viewer = Viewer.find(params[:id])
    end

    def set_channel_collection
      @channel_collection = Channel.all.collect {|i| [i.name, i.id] }
    end

    def set_post_buy_collection
      @post_buy_collection = PostBuy.all.collect {|i| [i.program, i.id] }
    end

    def viewer_params
      params.require(:viewer).permit(:channel, :program, :level_1, :level_2, :sector, :category, :advertiser, :product, :copy, :start_time, :end_time, :duration, :break_no, :pos_in_break, :break, :spot_type, :size, :cost, :t_second_cost, :st_video, :et_video, viewer_attributes: [ :market, :activity, :target, :day_part_or_variable, :tVR, :share, :'000s', :index ])
    end
end
