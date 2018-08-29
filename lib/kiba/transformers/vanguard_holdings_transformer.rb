# frozen_string_literal: true

class VanguardHoldingsTransformer
  attr_accessor :target_date, :current_state
  
  # State Machine for processing the Factor file
  # 
  #
  class HoldingsState
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
  
  class WaitingForCompositeState < HoldingsState
    def process_row(row)      
      if is_composite_header(row) 
        return CompositeState.new(row[1]), nil
      else
        return self, nil
      end
    end
  end
  
  class CompositeState < HoldingsState
    attr_accessor :composite
    
    def initialize(ticker)
      @composite = {:etfg_date => self.class.target_date,
                    :composite_ticker => ticker,
                    :total_holdings => 0}
    end
      
    def process_row(row)
      if 'FUND NAME' == row[0]
        self.composite[:composite_name] = row[1].strip
      elsif 'Fund Id' == row[0]
        self.composite[:fund_id] = row[1].strip
      elsif 'As of date' == row[0]
        self.composite[:as_of_date] = Date.strptime(row[1], '%d-%b-%Y') rescue nil
      elsif ['Equity holdings count', 'Bond holdings count', 'Short term reserve count'].include?(row[0])
        self.composite[:total_holdings] += row[1].to_i
      elsif 'Listed currency' == row[0]
        # Decide if this is real or not
        if self.composite[:as_of_date].nil? or (0 == self.composite[:total_holdings])
          # Empty composite - ignore
          # There can be multiple composite headers, but some have no holdings, 
          #   as evidenced by 0 count or no as of date
          return WaitingForCompositeState.new, nil
        end
      end
      
      if is_holdings_header(row)
        return ConstituentState.new(self.composite), nil
      else
        return self, nil
      end
    end
  end
  
  class ConstituentState < HoldingsState
    attr_accessor :composite
    
    def initialize(composite)
      @composite = composite
    end
    
    def process_row(row)
      if is_composite_header(row)
        return CompositeState.new(row[1]), nil
      else
        constituent = {:composite => self.composite,
                       :asset_type => row[1],
                       :constituent_name => row[2],
                       :constituent_ticker => row[3],
                       :cusip => row[4],
                       :sedol => row[5],
                       :isin => row[6],
                       :weight => row[7],
                       :sector => row[8],
                       :country => row[9],
                       :depository_receipt => row[10],                       
                       :market_value => row[11],
                       :face_amount => row[12],
                       :coupon_rate => row[13],
                       :maturity_date => row[14],
                       :shares => row[15]}
        return self, constituent
      end
    end
  end
  
  def initialize(args)
    HoldingsState.target_date = Date.parse(args[:target_date])
    @current_state = WaitingForCompositeState.new
  end

  def process(row)
    self.current_state, transformed_row = self.current_state.process_row(row)
    
    transformed_row
  end
end
