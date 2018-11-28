class DropTableVanguardEtfs < FeedMigrationBase[5.2]
  def up
    drop_table :vanguard_etfs
  end
  
  def down
    create_table :vanguard_etfs, :id => false do |t|
      t.date :etfg_date, :null => false
      t.date :trade_date, :null => false
      t.string :ticker, :limit => 64
      t.column :isin, 'character(12)'
      t.column :sedol, 'character(7)'
      t.column :cusip, 'character(9)'
      t.string :description, :limit => 128
      t.string :basket_type, :limit => 32
      t.decimal :nav, :precision => 22, :scale => 6
      t.string :status, :limit => 32
      t.decimal :creation_unit_shares, :precision => 22, :scale => 6
      t.decimal :application_value, :precision => 22, :scale => 6
      t.decimal :sum_market_value, :precision => 22, :scale => 6
      t.decimal :actual_cash, :precision => 22, :scale => 6
    end    
  end
end
