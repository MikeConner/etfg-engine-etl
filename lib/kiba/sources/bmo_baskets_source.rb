# frozen_string_literal: true
require 'csv'

class BmoBasketsSource
  def initialize(file)
    @file = file
  end

  # Yield each non-blank row; they are all different lengths
  def each
    CSV.foreach(@file, :encoding => 'iso-8859-1:utf-8') do |row|
      yield row unless row.empty?
    end
  end
end
