class AddDatasourceIdToFundFlows < ActiveRecord::Migration[5.2]
  def change
    add_column :date_adjust_fund_flows, :datasource_id, :integer
  end
end
