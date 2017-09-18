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
  validates :program, :level_1, :level_2, :cost, :channel_id, :start_time, :end_time, :duration, :st_video, :et_video, presence: true
  validates :cost, :start_time, :end_time, :duration, :st_video, :et_video, numericality: { only_integer: true }
  mount_uploader :video, VideoUploader do
    def url(format = nil)
      uploaded_path = encode_path(file.path.sub(File.expand_path(root), ''))
      return uploaded_path if format.nil?
      files = Dir.entries(File.dirname(file.path))
      files.each do |f|
        next unless File.extname(f) == '.' + format.to_s
        return File.dirname(uploaded_path) + '/' + f
      end
    end
  end

  class << self
    def dashboard_search(keyword, columns, date)
      if columns
        params = Hash[columns.map { |col| [col.to_sym, keyword] }]
        if params[:channel_id_in].present?
          c = Channel.where("name like ? ", "%#{keyword}%")
          params[:channel_id_in] = c.ids 
        end
        d = date.split(' - ')
        params[:m] = 'or'
        self.join_with_channel_and_post_buy_and_viewer_table.between_date(d[0], d[1]).ransack(params)
      else
        self.join_with_channel_and_post_buy_and_viewer_table.ransack
      end
    end
  end

  def self.between_date(range_1, range_2)
    where("television_programs.created_at >= ? AND television_programs.created_at <= ?",range_1 ,range_2 )
  end

  def self.join_with_channel_and_post_buy_and_viewer_table
    joins('LEFT JOIN "channels" ON "channels"."id" = "television_programs"."channel_id" LEFT JOIN "post_buys" ON "post_buys"."television_program_id" = "television_programs"."id" LEFT JOIN "viewers" ON "viewers"."post_buy_id" = "post_buys"."id"')
  end

  def self.chart_data
    select('channels.id, channels.name AS channel_name, sum(viewers."000s") AS sum_of_rating').group('channels.id, channels.name')
  end

  def self.chart_channel_names
    chart_data.map(&:channel_name) # => [GTV, TRANS7, TVONE, NET, ... ]
  end

  def self.chart_sum_of_rating
    chart_data.map(&:sum_of_rating) # sum of rating for every channel in array
  end

  def self.no_of_spot_data
    select('sum(viewers."000s") AS sum_no_of_spot')
  end
end
