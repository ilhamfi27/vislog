# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  channel_id :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Channel < ActiveRecord::Base
  has_many :television_programs
  has_many :post_buys, through: :television_programs
  has_many :viewers, through: :post_buys

  def self.chart_data
    joins(:viewers).select('channels.id, channels.name AS channel_name, sum(viewers."000s") AS sum_of_rating').group('television_programs.channel_id, channels.id, channels.name, viewers."000s"')
  end

  def self.chart_channel_names
    chart_data.map(&:channel_name) # => [GTV, TRANS7, TVONE, NET, ... ]
  end

  def self.chart_sum_of_rating
    chart_data.map(&:sum_of_rating) # sum of rating for every channel in array
  end
end
