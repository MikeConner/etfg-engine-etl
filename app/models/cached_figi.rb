# == Schema Information
#
# Table name: cached_figis
#
#  id           :bigint(8)        not null, primary key
#  input_ids    :string           not null
#  last_updated :date
#

class CachedFigi < ApplicationRecord
  CachedFigi.record_timestamps = false
end
