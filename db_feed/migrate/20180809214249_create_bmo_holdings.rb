class CreateBmoHoldings < FeedMigrationBase[5.2]
  def change
    create_table :bmo_holdings, :id => false do |t|
      t.string :composite_ticker, :limit => 32, :null => false
      t.string :constituent_ticker, :limit => 64, :null => false
      t.string :constituent_name, :limit => 128
      t.string :security_id, :limit => 32
      t.string :country, :limit => 64
      t.string :sedol, :limit => 7
      t.string :cusip, :limit => 9
      t.string :figi, :limit => 12
      t.decimal :total_shares_held, :precision => 18, :scale => 6
      t.decimal :market_value, :precision => 18, :scale => 6
      t.decimal :weight, :precision => 18, :scale => 6
    end
  end
end
