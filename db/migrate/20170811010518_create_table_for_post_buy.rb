class CreateTableForPostBuy < ActiveRecord::Migration
  def change
    create_table :post_buys do |t|
      t.date :date  
      t.string :channel 
      t.string :program 
      t.string :level_1 
      t.string :level_2 
      t.string :sector  
      t.string :category  
      t.string :advertiser  
      t.string :product 
      t.string :copy  
      t.time :start_time
      t.time :end_time  
      t.time :duration  
      t.integer :break_no 
      t.integer :pos_in_vreak
      t.integer :tot_spots_in 
      t.string :spot_type
      t.string :size
      t.integer :cost
      t.integer :t_second_cost
      t.time :st_video
      t.time :et_video
    end
  end
end
