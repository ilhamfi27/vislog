class CreateTableViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.string :market
      t.string :activity
      t.string :target  
      t.date :date  
      t.string :channel 
      t.string :day_part_or_variable 
      t.float :tVR 
      t.float :share 
      t.integer :"000s"  
      t.date :index
    end
  end
end
