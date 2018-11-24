# frozen_string_literal: true
require 'csv'

class VanguardBasketSource
  def initialize(file)
    @file = file
  end

  # Yield each non-blank row; they are all different lengths
  def each
    CSV.foreach(@file, :encoding => 'iso-8859-1:utf-8') do |row|
      # File has a footer - truncate at the last valid line
      break if row.empty?
      
      yield row
    end
  end
end
