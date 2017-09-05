# == Schema Information
#
# Table name: television_programs
#
#  id         :integer          not null, primary key
#  program    :string
#  level_1    :string
#  level_2    :string
#  cost       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel_id :integer
#  start_time :integer
#  end_time   :integer
#  duration   :integer
#  st_video   :integer
#  et_video   :integer
#  video      :string
#
# Indexes
#
#  index_television_programs_on_channel_id  (channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#

class TelevisionProgram < ActiveRecord::Base
  belongs_to :channel
  has_one :post_buy, dependent: :destroy 
  accepts_nested_attributes_for :post_buy

  mount_uploader :video, VideoUploader

  class << self
    def dashboard_search(keyword, columns, date)
      if columns
        params = Hash[columns.map { |col| [col, keyword] }]
        # d = date.split(' - ')
        # params[:created_at_gteq] = d[0]
        # params[:created_at_lteq] = d[1]
        params[:m] = 'or'
        self.ransack(params)
      else
        self.ransack
      end
    end
  end
end
