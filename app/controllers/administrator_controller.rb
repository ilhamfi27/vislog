class AdministratorController < ApplicationController
  before_action :show_all_television_program_data, only: [:index]
  before_action :show_all_channel_data, only: [:index]
  def index; end

  private
    def show_all_television_program_data
      @television_programs = TelevisionProgram.all
    end

    def show_all_channel_data
      @channels = Channel.all
    end
end
