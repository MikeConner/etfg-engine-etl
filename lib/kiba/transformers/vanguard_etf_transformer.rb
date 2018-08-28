# frozen_string_literal: true
require 'data_validation'

class VanguardETFTransformer
  include DataValidation
  
  attr_accessor :target_date
  
  def initialize(args)
    @target_date = Date.parse(args[:target_date])
  end

  def process(row)
    new_row = {:etfg_date => self.target_date}

    puts row
    
    new_row[:trade_date] = transform_date(row['Trade Date'])
    new_row[:ticker] = row['Ticker']
    new_row[:isin] = normalize_isin(row['ISIN'])
    new_row[:sedol] = normalize_sedol(row['SEDOL'])   
    new_row[:cusip] = normalize_cusip(row['CUSIP'])
    new_row[:description] = normalize_text(row['Description'], 128)  
    new_row[:nav] = normalize_float(row['NAV'])
    new_row[:status] = normalize_text(row['NAV'], 32)
    new_row[:creation_unit_shares] = normalize_float(row['Shares in Creation Units'])
    new_row[:application_value] = normalize_float(row['Application Value'])
    new_row[:sum_market_value] = normalize_float(row['Sum Of Market Value'])
    new_row[:actual_cash] = normalize_float(row['ActualCash '])
     
    new_row
  end
  
  def transform_date(date_str)
    date = Date.strptime(date_str, "%m/%d/%y")
    date.strftime("%Y%m%d")
  end  
end
