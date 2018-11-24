# frozen_string_literal: true

class VanguardBasketTransformer
  attr_accessor :target_date, :current_state
  
  # State Machine for processing the Factor file
  # 
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
    
    def is_composite_header(row)
      !row.nil? and 'FUND NAME' == row[0]
    end
    
    def is_holdings_header(row)
      !row.nil? and ['SEDOL', 'ISIN', 'DESCRIPTION'] == row[1..3]
    end
  end
  
  class WaitingForCompositeState < BasketState
    def process_row(row)      
      if is_composite_header(row) 
        return CompositeState.new(row[1].strip), nil
      else
        return self, nil
      end
    end
  end
  
  class CompositeState < BasketState
    attr_accessor :composite
    
    def initialize(fund_name)
      @composite = {:etfg_date => self.class.target_date,
                    :fund_name => fund_name}
    end

    def read_num(value)
      v = value.strip
      return '-' == v ? nil : v.to_f
    end

    def process_row(row)
      if is_holdings_header(row)
        return WaitingForCompositeState.new, self.composite
 
      elsif 'FUND IDENTIFIER' == row[0]
        self.composite[:fund_identifier] = row[1].strip
      elsif 'FUND IDENTIFIER TYPE' == row[0]
        self.composite[:fund_identifier_type] = row[1].strip
      elsif 'DOMICILE' == row[0]
        self.composite[:domicile] = row[1].strip
      elsif 'FUND TICKER' == row[0]
        self.composite[:fund_ticker] = row[1].strip
      elsif 'TRADE DATE' == row[0]
        self.composite[:trade_date] = Date.strptime(row[1], '%Y%m%d') rescue nil
      elsif 'UNIT SIZE' == row[0]
        self.composite[:unit_size] = read_num(row[1])
      elsif 'SHARES OUTSTANDING' == row[0]
        self.composite[:shares_outstanding] = read_num(row[1])
      elsif 'NAV' == row[0]
        self.composite[:nav] = read_num(row[1])
      elsif 'BASKET IDENTIFIER' == row[0]
        self.composite[:basket_identifier] = row[1].strip
      elsif 'BASKET IDENTIFIER TYPE' == row[0]
        self.composite[:basket_identifier_type] = row[1].strip
      elsif 'BASKET USAGE' == row[0]
        self.composite[:basket_usage] = read_num(row[1])
      elsif 'FIXED FEE CREATE' == row[0]
        self.composite[:fixed_fee_create] = read_num(row[1])
      elsif 'FIXED FEE REDEEM' == row[0]
        self.composite[:fixed_fee_redeem] = read_num(row[1])
      elsif 'TBA FEE' == row[0]
        self.composite[:tba_fee] = read_num(row[1])
      elsif 'CASH IN LIEU FEE' == row[0]
        self.composite[:cash_in_lieu_fee] = read_num(row[1])
      elsif 'STANDARD TO CUSTOM FEE' == row[0]
        self.composite[:standard_custom_fee] = read_num(row[1])
      elsif 'ACTUAL CASH COMPONENT' == row[0]
        self.composite[:actual_cash] = read_num(row[1])
      elsif 'ESTIMATED CASH COMPONENT' == row[0]
        self.composite[:estimated_cash] = read_num(row[1])
      elsif 'EXPENSE RATIO' == row[0]
        self.composite[:expense_ratio] = read_num(row[1])
      elsif 'DAILY CREATE UNIT LIMIT' == row[0]
        self.composite[:daily_create_unit_limit] = read_num(row[1])
      elsif 'DAILY REDEEM UNIT LIMIT' == row[0]
        self.composite[:daily_create_redeem_unit] = read_num(row[1])
      elsif 'BASE CURRENCY' == row[0]
        self.composite[:base_currency] = row[1].strip
      end
      
      return self, nil
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
