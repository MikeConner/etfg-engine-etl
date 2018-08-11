# frozen_string_literal: true
require 'csv'

class CSVSource
  # Read a completely clean CSV file, given the filename, expected column count, and options
  #   (common options would be encoding, and whether there are headers)
  def initialize(file, num_columns, options)
    @file = file
    @num_columns = num_columns
    @options = options
  end

  # Yield each row with the expected number of columns to a hash
  def each
    CSV.foreach(@file, @options) do |row|
      next unless @num_columns == row.count
      
      yield row.to_hash
    end
  end
end
