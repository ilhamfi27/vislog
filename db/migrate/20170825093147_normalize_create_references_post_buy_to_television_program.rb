class NormalizeCreateReferencesPostBuyToTelevisionProgram < ActiveRecord::Migration
  def change
    add_reference :post_buys, :television_program, index: true, foreign_key: true
  end
end
