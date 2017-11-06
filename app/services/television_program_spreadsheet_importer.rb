class TelevisionProgramSpreadsheetImporter < SpreadsheetImporter
  attr_reader :errors

  def initialize(file)
    @file = file
    @errors = []
    @television_programs = []
  end

  def import!
    spreadsheet = open_spreadsheet(@file)
    spreadsheet.default_sheet = spreadsheet.sheets[0]

    # validate_header!(spreadsheet)
    map_television_programs!(spreadsheet)

    # if is_valid
      TelevisionProgram.import @television_programs, validate: true
    # end
  end

  # def is_valid
  #   @errors.size == 0
  # end
  private

  def map_television_programs!(spreadsheet)
    channel_collection = set_channel_collection(spreadsheet)
    spreadsheet.each_with_index do |row, index|
      next if index == 0
      television_program = TelevisionProgram.new(
        program: row[2],
        level_1: row[3],
        level_2: row[4],
        cost: row[8].to_i,
        created_at: row[0],
        updated_at: row[0],
        channel_id: channel_collection[row[1]],
        start_time: time_to_integer(row[5]),
        end_time: time_to_integer(row[6]),
        duration: time_to_integer(row[7]),
        st_video: time_to_integer(row[9]),
        et_video: time_to_integer(row[10]),
      )

      if television_program.validate
        @television_programs.push(television_program)
      else
        @errors << { row: index, errors: television_program.errors.full_messages }
        television_program.errors.full_messages.each do |message|
          error = "Error on row #{index}, the error is #{message}"
          notification = Notification.new(message: error, category: 'Import Error')
          notification.save
        end
      end
    end
  end

  def set_channel_collection(spreadsheet)
    channels_name = spreadsheet.sheet(0).map{|r| r[1]}
    channels_name.shift
    channels_name.uniq!

    Hash[
      Channel.select(:id, :name)
      .where(name: channels_name)
      .map{|c| [c.name, c.id]}
    ]
  end
end