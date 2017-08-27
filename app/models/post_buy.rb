class PostBuy < ActiveRecord::Base
  belongs_to :channel
  belongs_to :television_program
  has_one :viewer, dependent: :destroy 
  accepts_nested_attributes_for :viewer
end
