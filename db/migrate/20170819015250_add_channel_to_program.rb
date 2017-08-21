class AddChannelToProgram < ActiveRecord::Migration
  def change
    add_reference :television_programs, :channel, index: true, foreign_key: true
    add_reference :post_buys, :channel, index: true, foreign_key: true
    add_reference :viewers, :channel, index: true, foreign_key: true
  end
end
