# frozen_string_literal: true
require 'data_validation'

class VanguardFactorDestination
  include DataValidation
  
  attr_accessor :constituents
  
  def initialize
    @constituents = []
  end

  def write(row)
    composite = row[:composite]
    
    self.constituents << VanguardFactor.new(:etfg_date => composite[:etfg_date],
                                            :as_of_date => composite[:as_of_date],
                                            :composite_ticker => composite[:composite_ticker],
                                            :composite_name => composite[:composite_name],
                                            :fund_id => composite[:fund_id],
                                            :asset_type => row[:asset_type],
                                            :constituent_ticker => row[:constituent_ticker],
                                            :constituent_name => row[:constituent_name],
                                            :isin => normalize_isin(row[:isin]),
                                            :weight => normalize_float(row[:weight]),
                                            :market_value => normalize_float(row[:market_value]),
                                            :shares => normalize_float(row[:shares]))
  rescue Exception => ex
    puts ex.message
  end
  
  def close
    VanguardFactor.import self.constituents
  end
end
