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
end
