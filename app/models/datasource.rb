# == Schema Information
#
# Table name: datasources
#
#  id                :bigint(8)        not null, primary key
#  data_source_name  :string(50)       not null
#  region            :string(2)        default("US"), not null
#  composite_rank    :integer          default(5)
#  constituent_rank  :integer          default(5)
#  composite_country :string(2)
#  source_type       :string(16)       default("direct_feed"), not null
#

class Datasource < ApplicationRecord
  DIRECT_FEED = 'direct_feed'
  BASKET = 'basket'
  MASTER_DATA = 'master_data'
  
  VALID_SOURCE_TYPES = [DIRECT_FEED, BASKET, MASTER_DATA]
  
  validates_inclusion_of :source_type, :in => VALID_SOURCE_TYPES
  
  def is_direct_feed
    DIRECT_FEED == self.source_type
  end
  
  def suffix
    case self.source_type
    when DIRECT_FEED
      ' (DF)'
    when BASKET
      ' (BK)'
    else
      ''
    end
  end
end
