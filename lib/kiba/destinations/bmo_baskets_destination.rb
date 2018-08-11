# frozen_string_literal: true
require 'data_validation'

class BmoBasketsDestination
  include DataValidation
  
  attr_accessor :composites, :constituents
  
  def initialize
    @composites = []
    @constituents = []
  end

  def write(row)
    case row[:row_type]
      when :composite
        self.composites << BmoBasketComposite.new(:etfg_date => row[:etfg_date],
                                                  :composite_ticker => row[:composite_ticker],
                                                  :account_number => row[:account_number],
                                                  :composite_name => row[:composite_name],
                                                  :units_outstanding => row[:units_outstanding],
                                                  :nav => row[:nav],
                                                  :projected_cash => row[:projected_cash],
                                                  :dist_price_adj => row[:dist_price_adj],
                                                  :fx_rate => row[:fx_rate],
                                                  :mer_expense_ratio => row[:mer_expense_ratio],
                                                  :prescribed_units => row[:prescribed_units],
                                                  :caf_pct => row[:caf_pct])
      when :constituent
        self.constituents << BmoBasketConstituent.new(:etfg_date => row[:etfg_date],
                                                      :composite_ticker => row[:composite_ticker],
                                                      :ticker => row[:ticker],
                                                      :constituent_ticker => row[:constituent_ticker],
                                                      :constituent_name => row[:constituent_name],
                                                      :constituent_country => row[:constituent_country],
                                                      :price => row[:price],
                                                      :shares_per_basket => row[:shares_per_basket],
                                                      :number_shares => row[:number_shares],
                                                      :sedol => normalize_sedol(row[:sedol]))
    end
    
  rescue Exception => ex
    puts ex.message
  end
  
  def close
    BmoBasketComposite.import self.composites
    BmoBasketConstituent.import self.constituents
  end
end
