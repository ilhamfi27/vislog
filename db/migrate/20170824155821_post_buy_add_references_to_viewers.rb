class PostBuyAddReferencesToViewers < ActiveRecord::Migration
  def change
    add_reference :viewers, :post_buy, index: true, foreign_key: true
  end
end
