class AdministratorController < ApplicationController
  before_action :show_all_television_program_data, only: [:index]
  before_action :show_all_channel_data, only: [:index]
  def index; end

  def invite_user
    if @user = User.invite!(:username => params[:user][:username], :name => params[:user][:name])
      redirect_to new_user_invitation_path, notice: 'User invited!'
    else
      redirect_to new_user_invitation_path, notice: 'User failed to invite!'
    end
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
  end

  private
    def show_all_television_program_data
      @television_programs = TelevisionProgram.all
    end

    def show_all_channel_data
      @channels = Channel.all
    end
end
