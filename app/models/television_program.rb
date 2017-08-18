class TelevisionProgram < ActiveRecord::Base
  class << self
    def dashboard_search(keyword, columns)
      if columns
        params = Hash[columns.map { |col| [col,keyword] }]
        self.ransack(params)
      else
        self.ransack
      end
    end
  end
end
