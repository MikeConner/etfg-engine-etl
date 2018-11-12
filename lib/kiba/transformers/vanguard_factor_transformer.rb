# frozen_string_literal: true

class VanguardFactorTransformer
  attr_accessor :target_date, :current_state
  
  # State Machine for processing the Factor file
  # 
  #
  class FactorState
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
    
    def is_composite_header(row)
      !row.nil? and 'TICKER' == row[0]
    end
    
    def is_holdings_header(row)
      !row.nil? and ['Asset type', 'Holding name', 'Ticker'] == row[1..3]
    end
  end
  
  class WaitingForCompositeState < FactorState
    def process_row(row)      
      if is_composite_header(row) 
        return CompositeState.new(row[1]), nil
      else
        return self, nil
      end
    end
  end
  
  class CompositeState < FactorState
    attr_accessor :composite
    
    def initialize(ticker)
      @composite = {:etfg_date => self.class.target_date,
                    :composite_ticker => ticker}
    end
      
    def process_row(row)
      return self, nil if row.nil?
      
      if 'FUND NAME' == row[0]
        @composite[:composite_name] = row[1].strip
      elsif 'Fund Id' == row[0]
        @composite[:fund_id] = row[1].strip
      elsif 'As of date' == row[0]
        fmt = 2 == row[1].split('-').last.length ? '%d-%b-%y' : '%d-%b-%Y'
        @composite[:as_of_date] = Date.strptime(row[1], fmt)
      end
      
      if is_holdings_header(row)
        return ConstituentState.new(self.composite), nil
      else
        return self, nil
      end
    end
  end
  
  class ConstituentState < FactorState
    attr_accessor :composite_ticker
    
    def initialize(composite_ticker)
      @composite_ticker = composite_ticker
    end
    
    def process_row(row)
      if row[1].blank?
        return WaitingForCompositeState.new, nil
      else
        constituent = {:composite => self.composite_ticker,
                       :asset_type => row[1].strip,
                       :constituent_name => row[2].strip,
                       :constituent_ticker => row[3].strip,
                       :isin => row[4].strip,
                       :weight => row[5].to_f,
                       :market_value => row[6].to_f,
                       :shares => row[7].to_f}
          
        return self, constituent
      end
    end
  end
  
  def initialize(args)
    FactorState.target_date = Date.parse(args[:target_date])
    @current_state = WaitingForCompositeState.new
  end

  def process(row)
    self.current_state, transformed_row = self.current_state.process_row(row)
    
    transformed_row
  end
end
