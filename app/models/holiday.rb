# == Schema Information
#
# Table name: holidays
#
#  market_day  :date             not null, primary key
#  is_open     :boolean          not null
#  description :string
#

class Holiday < ApplicationRecord
    Holiday.record_timestamps = false

    validates_presence_of :market_day
    validates_inclusion_of :is_open, :in => [true, false]    
end
