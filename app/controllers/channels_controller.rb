class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to new_channel_path, notice: 'Channel was successfully added.'
    else
      render :new
    end
  end

  def edit
    @channel = Channel.find(set_channel)
  end

  def update
    if @channel.update(channel_params)
      redirect_to edit_channel_path(set_channel.id), notice: 'channel was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @channel.destroy
    redirect_to administrator_path, notice: 'channel was successfully destroyed.'
  end


  private
    def set_channel
      @channel = Channel.find(params[:id])
    end


    def channel_params
      params.require(:channel).permit(:channel_id, :name)
    end
end
