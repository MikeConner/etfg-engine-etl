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
    
    new_row[:trade_date] = transform_date(row['Trade Date'])
    new_row[:ticker] = row['TICKER']
    new_row[:isin] = normalize_isin(row['ISIN'])
    new_row[:sedol] = normalize_sedol(row['SEDOL'])   
    new_row[:cusip] = normalize_cusip(row['CUSIP'])
    new_row[:description] = normalize_text(row['Description'], 128)  
    new_row[:nav] = normalize_float(row['NAV'])
    new_row[:status] = normalize_text(row['Status'], 32)
    new_row[:creation_unit_shares] = normalize_float(row['Shares in Creation Units'])
    new_row[:application_value] = normalize_float(row['Application Value'])
    new_row[:sum_market_value] = normalize_float(row['Sum Of Market Value'])
    new_row[:actual_cash] = normalize_float(row['Actual Cash'])
    new_row[:source_name] = 'ETF'
     
    new_row
  end
  
  def transform_date(date_str)
    Date.strptime(date_str, "%m/%d/%Y")
  end  
end
