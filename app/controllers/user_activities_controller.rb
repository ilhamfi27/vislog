class UserActivitiesController < ApplicationController

  def index
    @activity_record = ActivityRecord.all.order('created_at DESC')
  end
end
