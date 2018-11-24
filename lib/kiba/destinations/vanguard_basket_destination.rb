# frozen_string_literal: true
class VanguardBasketDestination
  attr_accessor :composites
  
  def initialize
    @composites = []
  end

  def write(row)
    self.composites << VanguardBasket.new(:etfg_date => row[:etfg_date],
                                          :fund_ticker => row[:fund_ticker],
                                          :shares_outstanding => row[:shares_outstanding],
                                          :nav => row[:nav],
                                          :fund_name => row[:fund_name],
                                          :fund_identifier => row[:fund_identifier],
                                          :fund_identifier_type => row[:fund_identifier_type],
                                          :domicile => row[:domicile],
                                          :trade_date => row[:trade_date],
                                          :unit_size => row[:unit_size],
                                          :basket_identifier => row[:basket_identifier],
                                          :basket_identifier_type => row[:basket_identifier_type],
                                          :basket_usage => row[:basket_usage],
                                          :fixed_fee_create => row[:fixed_fee_create],
                                          :fixed_fee_redeem => row[:fixed_fee_redeem],
                                          :tba_fee => row[:tba_fee],
                                          :cash_in_lieu_fee => row[:cash_in_lieu_fee],
                                          :standard_custom_fee => row[:standard_custom_fee],
                                          :actual_cash => row[:actual_cash],
                                          :estimated_cash => row[:estimated_cash],
                                          :expense_ratio => row[:expense_ratio],
                                          :daily_create_unit_limit => row[:daily_create_unit_limit],
                                          :daily_create_redeem_unit => row[:daily_create_redeem_unit],
                                          :base_currency => row[:base_currency])
  rescue Exception => ex
    puts ex.message
  end
  
  def close
    puts "Importing #{self.composites.count}"
    VanguardBasket.import self.composites
  end
end
