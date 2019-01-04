# == Schema Information
#
# Table name: issuers
#
#  id              :bigint(8)        not null
#  name            :string(32)       not null
#  effective_date  :date
#  expiration_date :date
#

class Issuer < ApplicationRecord
end
