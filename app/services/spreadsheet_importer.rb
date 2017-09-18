class SpreadsheetImporter
  private
  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def time_to_integer(time)
    time.split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
  end
end
