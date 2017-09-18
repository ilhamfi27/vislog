class ChangeIndexColumnOnViewersTableToString < ActiveRecord::Migration
  def self.up
    change_column :viewers, :index, :string
  end
 
  def self.down
    change_column :viewers, :index, :date
  end
end
