require "terminal-table"

module TableUtils
  class << self
    def print(data)
      return if data.empty?

      table = Terminal::Table.new(headings: headings(data), rows: rows(data))
      puts table
    end

    private

    def headings(data)
      data.first.attributes.keys
    end

    def rows(data)
      data.map { |item| item.attributes.values }
    end
  end
end
