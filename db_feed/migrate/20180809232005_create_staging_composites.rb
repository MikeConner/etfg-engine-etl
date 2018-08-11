class CreateStagingComposites < FeedMigrationBase[5.2]
  def change
    create_table :staging_composites do |t|
      t.date :etfg_date, :null => false
      t.date :as_of_date, :null => false
      t.integer :datasource_id, :limit => 2, :null => false
      t.integer :pooled_instrument_id, :limit => 8
      t.string :composite_ticker, :limit => 32
      t.string :composite_name, :limit => 128
      t.string :composite_description, :limit => 128
      t.decimal :aum, :precision => 18, :scale => 6
      t.decimal :shares_outstanding, :precision => 18, :scale => 6
      t.decimal :share_value, :precision => 18, :scale => 6
      t.decimal :nav, :precision => 18, :scale => 6
      t.decimal :open_price, :precision => 18, :scale => 6
      t.decimal :low_price, :precision => 18, :scale => 6
      t.decimal :high_price, :precision => 18, :scale => 6
      t.decimal :close_price, :precision => 18, :scale => 6
      t.decimal :daily_return, :precision => 18, :scale => 6
      t.decimal :bid_ask_spread, :precision => 18, :scale => 6
      t.decimal :avg_bid_size, :precision => 18, :scale => 6
      t.decimal :avg_ask_size, :precision => 18, :scale => 6
      t.decimal :avg_midpoint, :precision => 18, :scale => 6
      t.decimal :basket_estimated_cash, :precision => 18, :scale => 6
      t.integer :issuer_id
      t.string :issuer, :limit => 32
      t.column :figi, 'character(12)'
      t.boolean :is_exchange_figi
      t.column :sedol, 'character(7)'
      t.column :isin, 'character(12)'
      t.column :cusip, 'character(9)'
      t.string :exchange_country, :limit => 64
      t.string :currency, :limit => 16
      t.string :exchange, :limit => 64
      t.string :market_sector, :limit => 128
      t.string :security_type, :limit => 128
      t.string :sector, :limit => 64
      t.string :industry, :limit => 64
      t.string :industry_group, :limit => 128
      t.string :subindustry, :limit => 128
      t.string :rating, :limit => 32
      t.boolean :is_index
      t.boolean :is_active
      t.boolean :is_etn
      t.boolean :is_levered
      t.boolean :is_inverse
      t.boolean :has_derivatives
      t.boolean :options_available
      t.date :inception_date
      t.string :etp_structure_type, :limit => 50
      t.string :category, :limit => 28
      t.string :related_index, :limit => 50
      t.string :related_index_symbol, :limit => 16
      t.string :related_index_name, :limit => 50
      t.decimal :net_expenses, :precision => 18, :scale => 6
      t.decimal :expense_ratio, :precision => 18, :scale => 6
      t.decimal :total_expenses, :precision => 18, :scale => 6
      t.decimal :other_expenses, :precision => 18, :scale => 6
      t.string :listing_exchange, :limit => 64
      t.string :asset_class, :limit => 28
      t.string :development_class, :limit => 32
      t.string :focus, :limit => 28
      t.string :lead_market_maker, :limit => 128
      t.string :region, :limit => 28
      t.decimal :levered_amount, :precision => 18, :scale => 6
      t.date :maturity_date
      t.string :exposure_country, :limit => 64
      t.string :selection_criteria, :limit => 32
      t.string :weighting_scheme, :limit => 32
      t.string :administrator, :limit => 128
      t.string :advisor, :limit => 128
      t.string :distributor, :limit => 128
      t.decimal :fee_waivers, :precision => 18, :scale => 6
      t.string :fiscal_year_end, :limit => 16
      t.string :futures_commission_merchant, :limit => 128
      t.string :subadvisor, :limit => 128
      t.string :tax_classification, :limit => 128
      t.string :transfer_agent, :limit => 50
      t.string :trustee, :limit => 128
      t.decimal :creation_fee, :precision => 18, :scale => 6
      t.decimal :creation_unit_size, :precision => 18, :scale => 6
      t.string :custodian, :limit => 128
      t.string :distribution_frequency, :limit => 32
      t.decimal :management_fee, :precision => 18, :scale => 6
      t.string :portfolio_manager, :limit => 128
      t.string :primary_benchmark
      t.boolean :match, :null => false, :default => false
    end
    
    # These don't work across schemas, at least not in migrations
    #add_foreign_key :staging_composites, :datasources
    #add_foreign_key :staging_composites, :pooled_instruments
    
    add_index :staging_composites, [:etfg_date, :datasource_id]
    add_index :staging_composites, [:as_of_date, :datasource_id]
    add_index :staging_composites, :composite_ticker
    add_index :staging_composites, [:composite_ticker, :exchange_country], :name => 'ticker_country_composites'
    add_index :staging_composites, :figi
  end
end
