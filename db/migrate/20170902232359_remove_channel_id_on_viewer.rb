class RemoveChannelIdOnViewer < ActiveRecord::Migration
  def change
    remove_column :viewers, :channel_id 
  end
end
