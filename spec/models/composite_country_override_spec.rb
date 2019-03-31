# == Schema Information
#
# Table name: composite_country_overrides
#
#  id                :bigint(8)        not null, primary key
#  datasource_id     :bigint(8)        not null
#  composite_ticker  :string(32)       not null
#  composite_country :string(2)        not null
#

require 'rails_helper'

RSpec.describe CompositeCountryOverride, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
