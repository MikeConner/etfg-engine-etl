# == Schema Information
#
# Table name: issuer_exceptions
#
#  id                 :bigint(8)        not null
#  datasource_id      :integer          not null
#  file_date          :date             not null
#  tablename          :string(64)       not null
#  name_in_datasource :string(128)
#

class IssuerException < ApplicationRecord
  belongs_to :datasource
end
