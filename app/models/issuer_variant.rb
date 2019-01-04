# == Schema Information
#
# Table name: issuer_variants
#
#  id              :bigint(8)        not null
#  name            :string(32)       not null
#  datasource_id   :integer          not null
#  issuer_id       :integer
#  effective_date  :date
#  expiration_date :date
#

class IssuerVariant < ApplicationRecord
end
