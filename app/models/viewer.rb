class Viewer < ActiveRecord::Base
  belongs_to :post_buy
  belongs_to :channel
end
