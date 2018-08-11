class CreateBmoHoldings < FeedMigrationBase[5.2]
  def change
    create_table :bmo_holdings, :id => false do |t|
      t.date :etfg_date, :null => false
      t.string :composite_ticker, :limit => 32, :null => false
      t.string :constituent_ticker, :limit => 64, :null => false
      t.string :constituent_name, :limit => 128
      t.string :constituent_country, :limit => 64
      t.string :instrument_type, :limit => 128
      t.string :security_id, :limit => 64
      t.decimal :total_shares_held, :precision => 18, :scale => 6
      t.column :sedol, 'character(7)'
      t.column :cusip, 'character(9)'
    end
  end
end
