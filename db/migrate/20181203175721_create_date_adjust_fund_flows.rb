class CreateDateAdjustFundFlows < ActiveRecord::Migration[5.2]
  def change
    create_table :date_adjust_fund_flows, :id => false do |t|
      t.string :composite_ticker, :null => false, :limit => 32
      t.date :effective_date
      t.date :expiration_date
    end
    
    add_index :date_adjust_fund_flows, :composite_ticker, :unique => true
  end
end
