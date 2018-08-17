class CreateVanguardUsTables < FeedMigrationBase[5.2]
  def change
    create_table :vanguard_us_all_fund_holdings do |t|
      t.string :fund_ticker
      t.string :fund_name
      t.integer :fund_id
      t.date :as_of_date
      t.integer :equity_holdings_count
      t.integer :bond_holdings_count
      t.integer :short_term_reserve_count
      t.string :listed_currency
      t.string :listed_currency_symbol
      t.string :fund_currency
      t.string :fund_currency_symbol
      t.string :asset_type
      t.string :holding_name
      t.string :ticker
      t.string :cusip
      t.string :sedol
      t.string :isin
      t.decimal :percent_of_fund
      t.string :sector
      t.string :country
      t.string :security_depository_receipt_type
      t.bigint :market_value
      t.bigint :face_amount
      t.decimal :coupon_rate
      t.date :maturity_date_start
      t.date :maturity_date_end
      t.bigint :shares
      t.string :currency_code
      t.string :currency_symbol
      t.date :etfg_date
    end

    create_table :vanguard_us_etfnav do |t|
      t.string :ticker
      t.string :isin
      t.string :sedol
      t.string :cusip
      t.string :description
      t.date :trade_date
      t.decimal :nav
      t.string :status
      t.integer :shares_in_creation_units
      t.integer :application_value
      t.decimal :sum_of_market_value
      t.decimal :actualcash
      t.date :etfg_date
    end

    create_table :vanguard_us_fi_etfnav do |t|
      t.string :ticker
      t.string :isin
      t.string :sedol
      t.string :cusip
      t.string :description
      t.string :basket_type
      t.date :trade_date
      t.decimal :nav
      t.string :status
      t.integer :shares_in_creation_units
      t.integer :application_value
      t.decimal :sum_of_market_value
      t.decimal :actualcash
      t.date :etfg_date
    end
  end
end
