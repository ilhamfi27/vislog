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

require 'test_helper'

class ViewerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
