# == Schema Information
#
# Table name: holidays
#
#  id          :bigint(8)        not null
#  country     :string(2)        default("US"), not null
#  market_day  :date             not null
#  is_open     :boolean          not null
#  description :string
#

class Holiday < ApplicationRecord
    Holiday.record_timestamps = false

    validates_presence_of :market_day
    validates_inclusion_of :is_open, :in => [true, false]    
end
