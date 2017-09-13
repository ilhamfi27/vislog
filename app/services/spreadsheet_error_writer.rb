class SpreadsheetErrorWriter
  def initialize(file_path)
    @file_path = file_path
  end
  
  def write_errors(errors, file_path)
    errors.each { |error| error[:row] += 1 }
    script = "#{Rails.root}/bin/spreadsheet_write_error.py"
    output = ''
    IO.popen([script, @file_path, file_path], 'r+') do |io|
      io.puts errors.to_json
      io.close_write
      output = io.read
    end
    
    puts output
  end
end