class CreateVanguardUsFactorFundHoldings < FeedMigrationBase[5.2]
  def change
    create_table :vanguard_us_factor_fund_holdings do |t|
      t.string :fund_ticker
      t.string :fund_name
      t.integer :fund_id
      t.date :as_of_date
      t.string :asset_type
      t.string :holding_name
      t.string :ticker
      t.string :isin
      t.decimal :percent_of_fund
      t.bigint :market_value
      t.bigint :shares
      t.date :etfg_date
    end
  end
end
