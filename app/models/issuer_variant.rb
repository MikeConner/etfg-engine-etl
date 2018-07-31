# == Schema Information
#
# Table name: issuer_variants
#
#  id            :bigint(8)        not null, primary key
#  name          :string(32)       not null
#  datasource_id :integer          not null
#  issuer_id     :integer
#

class IssuerVariant < ApplicationRecord
end
