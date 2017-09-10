# == Schema Information
#
# Table name: viewers
#
#  id                   :integer          not null, primary key
#  market               :string
#  activity             :string
#  target               :string
#  day_part_or_variable :string
#  tVR                  :float
#  share                :float
#  000s                 :integer
#  index                :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  post_buy_id          :integer
#
# Indexes
#
#  index_viewers_on_post_buy_id  (post_buy_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_buy_id => post_buys.id)
#

class Viewer < ActiveRecord::Base
  belongs_to :post_buy
  # validates :market, :activity, :target, :day_part_or_variable, :tVR, :share, :"000s", :index, presence: true
  # validates :tVR, :share, :"000s", numericality: {only_integer: true}
end
