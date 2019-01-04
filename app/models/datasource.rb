# == Schema Information
#
# Table name: datasources
#
#  id               :bigint(8)        not null
#  data_source_name :string(50)       not null
#  is_direct_feed   :boolean          default(TRUE), not null
#  country          :string(2)        default("US"), not null
#

class Datasource < ApplicationRecord
end
