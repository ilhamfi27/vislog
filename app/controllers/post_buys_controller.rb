class PostBuysController < ApplicationController
  before_action :set_channel_collection, only: [:new, :edit]
  before_action :set_post_buy, only: [:show, :edit, :update, :destroy]

  def new
    @post_buy = PostBuy.new
    @post_buy.build_viewer
  end

  def create
    @post_buy = PostBuy.new(post_buy_params)
    @post_buy.start_time = to_seconds(post_buy_params[:start_time])
    @post_buy.end_time =  to_seconds(post_buy_params[:end_time])
    @post_buy.st_video =  to_seconds(post_buy_params[:st_video])
    @post_buy.et_video =  to_seconds(post_buy_params[:et_video])
    @post_buy.duration =  @post_buy.end_time - @post_buy.start_time
    if @post_buy.save
      redirect_to new_post_buy_path, notice: 'Program was successfully added.'
    else
      render :new
    end
  end

  def edit
    @post_buy = PostBuy.find(set_post_buy)
  end

  def update
    if @post_buy.update(post_buy_params)
      redirect_to edit_post_buy_path(set_post_buy.id), notice: 'post_buy was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post_buy.destroy
    redirect_to administrators_path, notice: 'post_buy was successfully destroyed.'
  end


  private
    def set_post_buy
      @post_buy = PostBuy.find(params[:id])
    end

    def set_channel_collection
      @channel_collection = Channel.all.collect {|i| [i.name, i.id] }
    end

    def post_buy_params
      params.require(:post_buy).permit(:channel, :program, :level_1, :level_2, :sector, :category, :advertiser, :product, :copy, :start_time, :end_time, :duration, :break_no, :pos_in_break, :break, :spot_type, :size, :cost, :t_second_cost, :st_video, :et_video, viewer_attributes: [ :market, :activity, :target, :day_part_or_variable, :tVR, :share, :'000s', :index ])
    end
end
