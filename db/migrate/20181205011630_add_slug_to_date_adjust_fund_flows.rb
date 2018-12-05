class AddSlugToDateAdjustFundFlows < ActiveRecord::Migration[5.2]
  def change
    add_column :date_adjust_fund_flows, :slug, :string
    add_index :date_adjust_fund_flows, :slug, unique: true
  end
end
