class CreateTableForTelevisionPrograms < ActiveRecord::Migration
  def change
    create_table :television_programs do |t|
      t.date :date  
      t.string :channel 
      t.string :program 
      t.string :level_1 
      t.string :level_2 
      t.time :start_time
      t.time :end_time  
      t.time :duration  
      t.string :size
      t.integer :cost
      t.time :st_video
      t.time :et_video
    end
  end
end
