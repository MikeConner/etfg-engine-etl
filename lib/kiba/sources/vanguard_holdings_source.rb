# frozen_string_literal: true
require 'csv'

class VanguardHoldingsSource
  def initialize(file)
    @file = file
    `perl -p -i -e 's/\r+\n$/\n/g' #{file}`
  end

  # Yield each row, including blanks for transitions; they are all different lengths
  def each
    CSV.foreach(@file, :encoding => 'iso-8859-1:utf-8') do |row|
      yield row
    end
  end
end
