# == Schema Information
#
# Table name: datasources
#
#  id               :bigint(8)        not null, primary key
#  data_source_name :string(50)       not null
#  is_direct_feed   :boolean          default(TRUE), not null
#  region           :string(2)        default("US"), not null
#  composite_rank   :integer          default(5)
#  constituent_rank :integer          default(5)
#

class Datasource < ApplicationRecord
end
