# frozen_string_literal: true
require 'csv'

class VanguardETFSource
  def initialize(file)
    @file = file
  end

  # Yield each non-blank row; they are all different lengths
  def each
    CSV.foreach(@file, :headers => true, :encoding => 'iso-8859-1:utf-8') do |row|
      # File has a footer - truncate at the last valid line
      break if row.empty?
      
      yield row.to_hash
    end
  end
end
