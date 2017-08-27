class TelevisionProgram < ActiveRecord::Base
  belongs_to :channel
  has_one :post_buy, dependent: :destroy 
  accepts_nested_attributes_for :post_buy

  mount_uploader :video, VideoUploader

  class << self
    def dashboard_search(keyword, columns)
      if columns
        params = Hash[columns.map { |col| [col, keyword] }]
        self.ransack(params)
      else
        self.ransack
      end
    end
  end
end
