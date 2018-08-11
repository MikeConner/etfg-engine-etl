class CreateBmoBasketComposites < FeedMigrationBase[5.2]
  def change
    create_table :bmo_basket_composites do |t|
      t.date :etfg_date, :null => false
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :account_number, :limit => 32
      t.string :composite_name, :limit => 128
      t.decimal :units_outstanding, :precision => 18, :scale => 6
      t.decimal :nav, :precision => 18, :scale => 6
      t.decimal :projected_cash, :precision => 18, :scale => 6
      t.decimal :dist_price_adj, :precision => 18, :scale => 6
      t.decimal :fx_rate, :precision => 18, :scale => 6
      t.decimal :mer_expense_ratio, :precision => 18, :scale => 6
      t.decimal :prescribed_units, :precision => 18, :scale => 6
      t.decimal :caf_pct, :precision => 18, :scale => 6
    end
  end
end
