class RedoTsIndustries < ActiveRecord::Migration[5.2]
  def up
    remove_column :ts_exposures, :as_of_date
    drop_table :ts_industries

    create_table :ts_industries do |t|
      t.date :etfg_date, :null => false
      t.string :composite_ticker, :limit => 32
      t.string :issuer, :limit => 64
      t.string :description, :limit => 128
      t.date :inception_date
      t.string :primary_benchmark
      t.string :tax_classification, :limit => 128
      t.boolean :is_etn
      t.decimal :aum, :precision => 22, :scale => 6
      t.decimal :avg_daily_trading_volume, :precision => 22, :scale => 6
      t.string :asset_class, :limit => 28
      t.string :category, :limit => 28
      t.string :focus, :limit => 28
      t.string :development_class, :limit => 32
      t.string :region, :limit => 28
      t.boolean :is_levered
      t.decimal :levered_amount, :precision => 22, :scale => 6
      t.boolean :is_active
      t.string :administrator, :limit => 128
      t.string :advisor, :limit => 128
      t.string :custodian, :limit => 128
      t.string :distributor, :limit => 128
      t.string :portfolio_manager
      t.string :subadvisor, :limit => 128
      t.string :transfer_agent, :limit => 50   
      t.string :trustee, :limit => 128
      t.string :futures_commission_merchant, :limit => 128
      t.string :fiscal_year_end, :limit => 16
      t.string :distribution_frequency, :limit => 32
      t.string :listing_exchange, :limit => 64
      t.decimal :creation_unit_size, :precision => 22, :scale => 6
      t.decimal :creation_fee, :precision => 22, :scale => 6
      t.text :geographic_exposure
      t.text :currency_exposure
      t.text :sector_exposure
      t.text :industry_group_exposure
      t.text :industry_exposure
      t.text :subindustry_exposure
      t.text :coupon_exposure
      t.text :maturity_exposure
      t.boolean :options_available
      t.decimal :options_volume, :precision => 22, :scale => 6
      t.decimal :short_interest, :precision => 22, :scale => 6
      t.decimal :put_call_ratio, :precision => 18, :scale => 6
      t.decimal :num_holdings, :precision => 18, :scale => 6
      t.decimal :discount_premium, :precision => 18, :scale => 6
      t.decimal :bid_ask_spread, :precision => 18, :scale => 6
      t.decimal :put_volume, :precision => 18, :scale => 6
      t.decimal :call_volume, :precision => 18, :scale => 6
      t.decimal :management_fee, :precision => 18, :scale => 6
      t.decimal :other_expenses, :precision => 18, :scale => 6
      t.decimal :total_expenses, :precision => 18, :scale => 6
      t.decimal :fee_waivers, :precision => 18, :scale => 6
      t.decimal :net_expenses, :precision => 18, :scale => 6    
      t.string :lead_market_maker, :limit => 128
      t.integer :pooled_instrument_id, :limit => 8, :null => false
    end
    
    add_index :ts_industries, :etfg_date
    add_index :ts_industries, :composite_ticker
  end
  
  def down
    add_column :ts_exposures, :as_of_date, :date
    drop_table :ts_industries
    
    create_table :ts_industries do |t|
      t.date :etfg_date, :null => false
      t.date :as_of_date, :null => false
      t.integer :datasource_id, :null => false, :limit => 2
      t.decimal :avg_daily_trading_volume, :precision => 18, :scale => 6
      t.decimal :call_volume, :precision => 18, :scale => 6
      t.decimal :discount_premium, :precision => 18, :scale => 6
      t.decimal :num_holdings, :precision => 18, :scale => 6
      t.decimal :options_volume, :precision => 18, :scale => 6
      t.decimal :put_call_ratio, :precision => 18, :scale => 6
      t.decimal :put_volume, :precision => 18, :scale => 6
      t.decimal :short_interest, :precision => 18, :scale => 6
      t.decimal :avg_bid_size, :precision => 18, :scale => 6
      t.decimal :avg_ask_size, :precision => 18, :scale => 6
      t.decimal :bid_ask_spread, :precision => 18, :scale => 6
      t.decimal :avg_midpoint, :precision => 18, :scale => 6
      t.decimal :open_price, :precision => 18, :scale => 6
      t.decimal :high_price, :precision => 18, :scale => 6
      t.decimal :low_price, :precision => 18, :scale => 6
      t.decimal :close_price, :precision => 18, :scale => 6
      t.decimal :daily_return, :precision => 18, :scale => 6
      t.decimal :basket_estimated_cash, :precision => 18, :scale => 6
      t.integer :pooled_instrument_id, :limit => 8
    end
  end
end
