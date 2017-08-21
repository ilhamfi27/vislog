class RemoveColumnChannelFromAllTables < ActiveRecord::Migration
  def change
    remove_column :post_buys, :channel
    remove_column :television_programs, :channel
    remove_column :viewers, :channel
  end
end
