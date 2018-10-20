# == Schema Information
#
# Table name: dag_statuses
#
#  id         :bigint(8)        not null, primary key
#  datasource :string(32)       not null
#  etfg_date  :date             not null
#  process    :string(64)       not null
#  status     :string(128)      not null
#  completed  :boolean          default(FALSE), not null
#  updated_at :date
#

class DagStatus < QcProcessSchemaBase
  DagStatus.record_timestamps = false
  
  scope :running, -> { where("completed=#{ActiveRecord::Base.connection.quoted_false}") }
end
