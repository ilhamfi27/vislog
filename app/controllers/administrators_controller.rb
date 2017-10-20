class AdministratorsController < ApplicationController
  before_action :show_all_television_program_data, only: [:index]
  before_action :show_all_channel_data, only: [:index]
  def index; end

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

  def user_registration
    @users = User.all
  end

  def add_user
    @user = User.new(add_user_params)
    @user.password_confirmation = add_user_params[:password]
    if @user.save
      redirect_to user_registration_on_administrators_path, notice: 'User was successfully added.'
    else
      redirect_to user_registration_on_administrators_path, notice: 'User was failed to add.'
    end

  end

  private
    def show_all_television_program_data
      @television_programs = TelevisionProgram.includes(:channel)
    end

    def show_all_channel_data
      @channels = Channel.all
    end

    def add_user_params
      params.permit(:email, :username, :password)
    end
end
