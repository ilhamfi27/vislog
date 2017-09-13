class AdministratorsController < ApplicationController
  before_action :show_all_television_program_data, only: [:index]
  before_action :show_all_channel_data, only: [:index]
  def index; end

  def invite_user
    @user = User.invite!(:username => params[:user][:username], :name => params[:user][:name]) do |u|
      u.skip_invitation = true
    end
    token = Devise::VERSION >= "3.1.0" ? @user.instance_variable_get(:@raw_invitation_token) : @user.invitation_token
    User.accept_invitation!(:invitation_token => token, :password => password, :password_confirmation => password)
    record_activity("Invite user")
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

  private
    def show_all_television_program_data
      @television_programs = TelevisionProgram.includes(:channel)
    end

    def show_all_channel_data
      @channels = Channel.all
    end
end
