# frozen_string_literal: true
require 'data_validation'

class VanguardHoldingsDestination
  include DataValidation
  
  attr_accessor :holdings
  
  def initialize
    @holdings = []
  end

  def write(row)
    composite = row[:composite]
    
    self.holdings << VanguardHolding.new(:etfg_date => composite[:etfg_date],
                                         :as_of_date => composite[:as_of_date],
                                         :composite_ticker => composite[:composite_ticker],
                                         :composite_name => composite[:composite_name],
                                         :fund_id => composite[:fund_id],
                                         :asset_type => row[:asset_type],
                                         :constituent_ticker => row[:constituent_ticker],
                                         :constituent_name => row[:constituent_name],
                                         :cusip => normalize_cusip(row[:cusip]),
                                         :sedol => normalize_sedol(row[:sedol]),
                                         :isin => normalize_isin(row[:isin]),
                                         :weight => normalize_float(row[:weight]),
                                         :sector => normalize_text(row[:sector], 64),
                                         :country => normalize_text(row[:country], 64),
                                         :depository_receipt => normalize_text(row[:depository_receipt], 32),
                                         :market_value => normalize_float(row[:market_value]),
                                         :face_amount => normalize_float(row[:face_amount]),
                                         :coupon_rate => normalize_float(row[:coupon_rate]),
                                         :maturity_date => normalize_date(row[:maturity_date], '%d-%b-%Y'),
                                         :shares => normalize_float(row[:shares]))
  rescue Exception => ex
    puts ex.message
  end
  
  def close
    VanguardHolding.import self.holdings
  end
end
