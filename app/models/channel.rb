class Channel < ActiveRecord::Base
  has_many :program_televisions
  has_many :viewers
  has_many :post_buys
end
