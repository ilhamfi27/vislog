class PostBuy < ActiveRecord::Base
  belongs_to :channel
  has_one :viewer
  accepts_nested_attributes_for :viewer
end
