class RemoveColumnSizeOnTelevisionProgram < ActiveRecord::Migration
  def change
    remove_column :television_programs, :size
  end
end
