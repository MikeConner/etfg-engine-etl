class CreateVanguardFactors < FeedMigrationBase[5.2]
  def change
    create_table :vanguard_factors, :id => false do |t|
      t.date :etfg_date, :null => false
      t.date :as_of_date, :null => false
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :composite_name, :null => false, :limit => 128
      t.string :fund_id, :limit => 32
      t.string :asset_type, :limit => 128
      t.string :constituent_ticker, :limit => 64
      t.string :constituent_name, :limit => 128
      t.column :isin, 'character(12)'
      t.decimal :weight, :precision => 22, :scale => 6
      t.decimal :market_value, :precision => 22, :scale => 6
      t.decimal :shares, :precision => 22, :scale => 6
    end
  end
end
