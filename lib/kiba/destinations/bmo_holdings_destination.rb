# frozen_string_literal: true

class BmoHoldingsDestination
  attr_accessor :holdings
  
  def initialize
    @holdings = []
  end
  
  def write(row)
    self.holdings << BmoHolding.new(:etfg_date => row[:etfg_date],
                                    :composite_ticker => row[:composite_ticker],
                                    :constituent_ticker => row[:constituent_ticker],
                                    :constituent_name => row[:constituent_name],
                                    :constituent_country => row[:constituent_country],
                                    :instrument_type => row[:instrument_type],
                                    :security_id => row[:security_id],
                                    :total_shares_held => row[:total_shares_held],
                                    :cusip => row[:cusip],
                                    :sedol => row[:sedol])
  rescue Exception => ex
    puts ex.message
  end
  
  def close
    BmoHolding.import self.holdings
  end
end
