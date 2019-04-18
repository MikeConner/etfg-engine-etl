# == Schema Information
#
# Table name: first_asset_funds
#
#  ticker    :string(4)        not null, primary key
#  fund_name :string(128)
#  address   :string           not null
#

class FirstAssetFund < FeedSchemaBase
  self.record_timestamps = false
  self.primary_key = :ticker

  validates_length_of :ticker, :maximum => 4
  validates_length_of :fund_name, :maximum => 16, :allow_nil => true
  validates_presence_of :address
end
