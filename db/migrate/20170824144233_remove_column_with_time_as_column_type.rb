class RemoveColumnWithTimeAsColumnType < ActiveRecord::Migration
  def change
    remove_column :post_buys, :start_time, :time
    remove_column :post_buys, :end_time, :time
    remove_column :post_buys, :duration, :time
    remove_column :post_buys, :st_video, :time
    remove_column :post_buys, :et_video, :time
    remove_column :television_programs, :start_time, :time
    remove_column :television_programs, :end_time, :time
    remove_column :television_programs, :duration, :time
    remove_column :television_programs, :st_video, :time
    remove_column :television_programs, :et_video, :time
  end
end
