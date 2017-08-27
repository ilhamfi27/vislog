class AddColumnForVideoUrlOnTelevisionProgramTable < ActiveRecord::Migration
  def change
    add_column :television_programs, :video, :string
  end
end
