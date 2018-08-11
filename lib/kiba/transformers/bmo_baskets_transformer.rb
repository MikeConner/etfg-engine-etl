# frozen_string_literal: true
require 'bmo_helper'

class BmoBasketsTransformer
  include BMOHelper

  attr_accessor :target_date, :current_state
  
  # State Machine for processing the basket file
  # 
  # WaitingForCompositeState -> [Find composite header row] -> CompositeState
  # CompositeState -> [Yield a composite row] -> WaitingForConstituentState(pass through composite ticker)
  # WaitingForConstituentState -> [Find constituent header row] -> ConstituentState
  #                            -> [Find bond row (with CUSIP)] -> WaitingForCompositeState
  # ConstituentState -> [Found a blank row] -> WaitingForCompositeState
  #                else [Yield a constituent row]
  #
  class BasketState
    @@target_date = nil
     
    def self.target_date=(value)
      @@target_date = value
    end    

    def self.target_date
      @@target_date
    end
    
    def process_row(row)
      raise 'Subclass responsibility'
    end
    
    def is_basket_composite_header(row)
      !row.nil? and row.length > 3 and ['Ticker', 'Fund Account Number', 'Fund Name'] == row[0..2]
    end
    
    def is_basket_constituent_header(row)
      !row.nil? and row.length > 4 and ['Name', 'Ticker', 'Shares Per Basket', 'Price'] == row[0..3]
    end
    
    def is_basket_bond_header(row)
      !row.nil? and row.length > 4 and ['Name', 'Coupon', 'Maturity', 'CUSIP'] == row[0..3]
    end
  end
  
  class WaitingForCompositeState < BasketState
    def process_row(row)      
      if is_basket_composite_header(row) 
        return CompositeState.new, nil
      else
        return self, nil
      end
    end
  end
  
  class CompositeState < BasketState
    def process_row(row)
      composite = {:row_type => :composite,
                   :etfg_date => self.class.target_date,
                   :composite_ticker => row[0],
                   :account_number => row[1],
                   :composite_name => row[2],
                   :units_outstanding => row[3].to_f,
                   :nav => row[4].to_f,
                   :projected_cash => row[5].to_f,
                   :dist_price_adj => row[6].to_f,
                   :fx_rate => row[7].to_f,
                   :mer_expense_ratio => row[8].to_f,
                   :prescribed_units => row[9].to_f,
                   :caf_pct => row[10].to_f}
                   
      return WaitingForConstituentState.new(composite[:composite_ticker]), composite
    end
  end
  
  class WaitingForConstituentState < BasketState
    attr_accessor :composite_ticker
    
    def initialize(composite_ticker)
      @composite_ticker = composite_ticker
    end

    def process_row(row)      
      if is_basket_constituent_header(row)
        return ConstituentState.new(self.composite_ticker), nil
      elsif is_basket_bond_header(row)
        # If we hit one of these rows, we've gone off the end into bonds, which we ignore
        # So just wait for the next composite
        return WaitingForCompositeState.new, nil
      else
        return self, nil
      end
    end
  end

  class ConstituentState < BasketState
    include BMOHelper
    
    attr_accessor :composite_ticker
    
    def initialize(composite_ticker)
      @composite_ticker = composite_ticker
    end
    
    def process_row(row)
      if row[0].blank?
        return WaitingForCompositeState.new, nil
      else
        constituent = {:row_type => :constituent,
                       :etfg_date => self.class.target_date,
                       :composite_ticker => self.composite_ticker,
                       :constituent_name => row[0],
                       :ticker => row[1],
                       :shares_per_basket => row[2].to_f,
                       :price => row[3].to_f,
                       :number_shares => row[4].to_f,
                       :sedol => row[5]}
        
        # Split ticker into ticker/country, if applicable
        constituent[:constituent_ticker], constituent[:constituent_country] = parse_ticker_country(constituent[:ticker])
               
        return self, constituent
      end
    end
  end
  
  def initialize(args)
    BasketState.target_date = Date.parse(args[:target_date])
    @current_state = WaitingForCompositeState.new
  end

  def process(row)
    self.current_state, transformed_row = self.current_state.process_row(row)
    
    transformed_row
  end
end
