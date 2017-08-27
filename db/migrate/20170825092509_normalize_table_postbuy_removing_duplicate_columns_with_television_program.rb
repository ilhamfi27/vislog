class NormalizeTablePostbuyRemovingDuplicateColumnsWithTelevisionProgram < ActiveRecord::Migration
  def change
    remove_column :post_buys, :channel_id
    remove_column :post_buys, :program 
    remove_column :post_buys, :level_1 
    remove_column :post_buys, :level_2 
    remove_column :post_buys, :start_time
    remove_column :post_buys, :end_time  
    remove_column :post_buys, :duration  
    remove_column :post_buys, :cost
    remove_column :post_buys, :st_video
    remove_column :post_buys, :et_video
  end
end
