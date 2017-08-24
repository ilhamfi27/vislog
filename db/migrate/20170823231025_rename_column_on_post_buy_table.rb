class RenameColumnOnPostBuyTable < ActiveRecord::Migration
  def change
    rename_column :post_buys, :pos_in_vreak, :pos_in_break
    rename_column :post_buys, :tot_spots_in, :break
  end
end
