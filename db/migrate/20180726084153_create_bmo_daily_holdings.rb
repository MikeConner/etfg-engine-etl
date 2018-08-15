class CreateBmoDailyHoldings < ActiveRecord::Migration[5.2]
  def change
    create_table :bmo_daily_holdings do |t|
      t.string :ticker
      t.string :instrument_type
      t.string :name
      t.string :sedol
      t.string :cusip
      t.string :security_id
      t.integer :quantity_per_paramount
      t.date :etfg_date
    end
  end
end
