class AddColumnForTimeAsInteger < ActiveRecord::Migration
  def change
    add_column :post_buys, :start_time, :integer
    add_column :post_buys, :end_time, :integer
    add_column :post_buys, :duration, :integer
    add_column :post_buys, :st_video, :integer
    add_column :post_buys, :et_video, :integer
    add_column :television_programs, :start_time, :integer
    add_column :television_programs, :end_time, :integer
    add_column :television_programs, :duration, :integer
    add_column :television_programs, :st_video, :integer
    add_column :television_programs, :et_video, :integer
  end
end
