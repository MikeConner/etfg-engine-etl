# frozen_string_literal: true
require 'data_validation'

class BmoHoldingsTransformer
  # This file has a single format with the following fields
  # Ticker  BANK -> bmo_holdings.composite_ticker -> staging_constituents.composite_ticker (instruments.composite_ticker)
  # InstrumentType  Equity (Ignored)
  # Name  AOZORA BANK LTD -> bmo_holdings.constituent_name -> staging_constituents.constituent_name (instruments.constituent_name)
  # SEDOL B1G1854 -> bmo_holdings.sedol -> staging_constituents.sedol (instruments.sedol)
  # CUSIP -> bmo_holdings.cusip -> staging_constituents.cusip (instruments.cusip)
  # InstrumentType - bmo_holdings.instrument_type -> staging_constituents.security_type (instruments.security_type) [Unused for now]
  # SecurityID  - store as is (for traceability), then 
  #   8304 JP -> complex parse: 
  #   "8304" -> bmo_holdings.constituent_ticker -> staging_constituents.constituent_ticker (instruemnts.constituent_ticker)
  #   "JP" -> bmo_holdings.constituent_country -> staging_constituents.exchange_country (instruments.exchange_country)
  #   If not in "ticker country" format, it's all the ticker
  # Quantity/ParAmount  200  -> bmo_holdings.total_shares_held -> staging_constituents.total_shares_held (ts_instruments.total_shares_held)
  include DataValidation
  include BMOHelper
  
  attr_accessor :target_date
  
  def initialize(args)
    @target_date = Date.parse(args[:target_date])
  end

  def process(row)
    new_row = {:etfg_date => self.target_date}
    
    new_row[:composite_ticker] = row['Ticker']
    new_row[:instrument_type] = row['InstrumentType']
    new_row[:constituent_name] = row['Name']
    new_row[:sedol] = cleanup_data(row['SEDOL'])
    new_row[:cusip] = cleanup_data(row['CUSIP'])
    new_row[:security_id] = cleanup_data(row['SecurityID'])
    new_row[:total_shares_held] = row['Quantity/ParAmount'].to_f
    
    # Now parse out the SecurityID
    new_row[:constituent_ticker], new_row[:constituent_country] = parse_ticker_country(new_row[:security_id])
    
    new_row
  end
end
