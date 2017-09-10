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
  # validates :program, :level_1, :level_2, :cost, :channel_id, :start_time, :end_time, :duration, :st_video, :et_video, presence: true
  # validates :cost, :start_time, :end_time, :duration, :st_video, :et_video, numericality: { only_integer: true }
  mount_uploader :video, VideoUploader

  class << self
    def dashboard_search(keyword, columns, date)
      if columns
        params = Hash[columns.map { |col| [col.to_sym, keyword] }]
        if params[:channel_id_in].present?
          c = Channel.where("name like ? ", "%#{keyword}%")
          params[:channel_id_in] = c.ids 
        end
        d = date.split(' - ')
        # params[:created_at_gteq] = d[0]
        # params[:created_at_lteq] = d[1]
        params[:m] = 'or'
        self.joins(:channel, post_buy: [:viewer]).between_date(d[0], d[1]).ransack(params)
      else
        self.joins(:channel, post_buy: [:viewer]).ransack
      end
    end
  end

  def self.between_date(range_1, range_2)
    where("television_programs.created_at >= ? AND television_programs.created_at <= ?",range_1 ,range_2 )
  end

  def self.chart_data
    select('channels.id, channels.name AS channel_name, sum(viewers."000s") AS sum_of_rating').group('television_programs.channel_id, channels.id, channels.name, viewers."000s"')
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

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      # code here
      channel = Channel.find_or_initialize_by(name: spreadsheet.row(i)[1])
      television_program = new
      television_program.program = spreadsheet.row(i)[2]
      television_program.level_1 = spreadsheet.row(i)[3]
      television_program.level_2 = spreadsheet.row(i)[4]
      television_program.cost = spreadsheet.row(i)[8].to_i
      television_program.created_at = spreadsheet.row(i)[0]
      television_program.updated_at = spreadsheet.row(i)[0]
      television_program.channel_id = channel.id
      television_program.start_time = spreadsheet.row(i)[5].split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
      television_program.end_time = spreadsheet.row(i)[6].split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
      television_program.duration = spreadsheet.row(i)[7].split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
      television_program.st_video = spreadsheet.row(i)[9].split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
      television_program.et_video = spreadsheet.row(i)[10].split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
      unless television_program.save && television_program.valid?
        return false
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
