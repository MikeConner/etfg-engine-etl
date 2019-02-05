# == Schema Information
#
# Table name: asset_class_lookups
#
#  id            :bigint(8)        not null, primary key
#  security_type :string
#  asset_class   :string(128)
#

require 'rails_helper'

RSpec.describe AssetClassLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
