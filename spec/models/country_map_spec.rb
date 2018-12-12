# == Schema Information
#
# Table name: country_maps
#
#  country     :string(64)       not null, primary key
#  iso_a2_code :string(2)
#  iso_a3_code :string(3)
#

require 'rails_helper'

RSpec.describe CountryMap, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
