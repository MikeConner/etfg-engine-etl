# == Schema Information
#
# Table name: known_exceptions
#
#  id               :bigint(8)        not null, primary key
#  datasource_id    :integer          not null
#  effective_date   :date
#  expiration_date  :date
#  constituent_name :text             not null
#  id_type          :string(8)        not null
#  id_value         :string(12)       not null
#  country          :string(64)
#  currency         :string(16)
#  figi             :string(12)
#  sedol            :string(7)
#  isin             :string(12)
#  cusip            :string(9)
#  composite_ticker :string(32)
#

class KnownException < ApplicationRecord
  belongs_to :datasource
end
