class CreateVanguardBaskets < FeedMigrationBase[5.2]
  def change
    create_table :vanguard_baskets, :id => false do |t|
      t.date :etfg_date
      t.string :fund_name, :limit => 128
      t.string :fund_identifier, :limit => 14
      t.string :fund_identifier_type, :limit => 32
      t.string :domicile, :limit => 32
      t.string :fund_ticker, :null => false, :limit => 32
      t.date :trade_date
      t.decimal :unit_size, :precision => 22, :scale => 6
      t.decimal :shares_outstanding, :precision => 22, :scale => 6
      t.decimal :nav, :precision => 22, :scale => 6
      t.string :basket_identifier, :limit => 14
      t.string :basket_identifier_type, :limit => 32
      t.string :basket_usage, :limit => 32
      t.decimal :fixed_fee_create, :precision => 22, :scale => 6
      t.decimal :fixed_fee_redeem, :precision => 22, :scale => 6
      t.decimal :tba_fee, :precision => 22, :scale => 6
      t.decimal :cash_in_lieu_fee, :precision => 22, :scale => 6
      t.decimal :standard_custom_fee, :precision => 22, :scale => 6
      t.decimal :actual_cash, :precision => 22, :scale => 6
      t.decimal :estimated_cash, :precision => 22, :scale => 6
      t.decimal :expense_ratio, :precision => 22, :scale => 6
      t.decimal :daily_create_unit_limit, :precision => 22, :scale => 6
      t.decimal :daily_create_redeem_unit, :precision => 22, :scale => 6
      t.string :base_currency, :limit => 16
    end
  end
end
