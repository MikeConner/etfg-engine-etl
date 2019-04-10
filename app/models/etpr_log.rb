# == Schema Information
#
# Table name: etpr_logs
#
#  id               :bigint(8)        not null, primary key
#  upload_date      :date             not null
#  composite_ticker :string(32)       not null
#  exchange_country :string(64)       not null
#  result           :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class EtprLog < ApplicationRecord
end
