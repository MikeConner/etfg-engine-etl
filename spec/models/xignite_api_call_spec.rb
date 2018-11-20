# == Schema Information
#
# Table name: xignite_api_calls
#
#  cusip    :string(9)        not null, primary key
#  industry :string(64)
#  sector   :string(128)
#  data     :text
#

require 'rails_helper'

RSpec.describe XigniteApiCall, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
