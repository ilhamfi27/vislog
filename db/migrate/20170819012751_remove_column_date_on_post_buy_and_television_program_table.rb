class RemoveColumnDateOnPostBuyAndTelevisionProgramTable < ActiveRecord::Migration
  def change
    # remove column date on postbuy, viewers and televison programs tables
    remove_column :post_buys, :date
    remove_column :television_programs, :date
    remove_column :viewers, :date

    # add timestamp to postbuys, television programs, and viewers
    add_column :post_buys, :created_at, :datetime, null: false
    add_column :post_buys, :updated_at, :datetime, null: false
    
    add_column :television_programs, :created_at, :datetime, null: false
    add_column :television_programs, :updated_at, :datetime, null: false
    
    add_column :viewers, :created_at, :datetime, null: false
    add_column :viewers, :updated_at, :datetime, null: false    
  end
end
