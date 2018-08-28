# frozen_string_literal: true

class VanguardETFDestination
  attr_accessor :etfs
  
  def initialize
    @etfs = []
  end

  def write(row)
    self.etfs << VanguardEtf.new(:etfg_date => row[:etfg_date],
                                 :trade_date => row[:trade_date],
                                 :ticker => row[:ticker],
                                 :isin => row[:isin],
                                 :sedol => row[:sedol],
                                 :cusip => row[:cusip],
                                 :description => row[:description],
                                 :basket_type => row[:basket_type],
                                 :nav => row[:nav],
                                 :status => row[:status],
                                 :creation_unit_shares => row[:creation_unit_shares],
                                 :application_value => row[:application_value],
                                 :sum_market_value => row[:sum_market_value],
                                 :actual_cash => row[:actual_cash])
  rescue Exception => ex
    puts ex.message
  end
  
  def close
    VanguardEtf.import self.etfs
  end
end
