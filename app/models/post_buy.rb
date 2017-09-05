# == Schema Information
#
# Table name: post_buys
#
#  id                    :integer          not null, primary key
#  sector                :string
#  category              :string
#  advertiser            :string
#  product               :string
#  copy                  :string
#  break_no              :integer
#  pos_in_break          :integer
#  break                 :integer
#  spot_type             :string
#  size                  :string
#  t_second_cost         :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  television_program_id :integer
#
# Indexes
#
#  index_post_buys_on_television_program_id  (television_program_id)
#
# Foreign Keys
#
#  fk_rails_...  (television_program_id => television_programs.id)
#

class PostBuy < ActiveRecord::Base
  belongs_to :television_program
  has_one :viewer, dependent: :destroy 
  accepts_nested_attributes_for :viewer
end
