class CreateBmoBasketConstituents < FeedMigrationBase[5.2]
  def change
    create_table :bmo_basket_constituents do |t|
      t.date :etfg_date, :null => false
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :ticker, :limit => 64
      t.string :constituent_ticker, :limit => 64
      t.string :constituent_name, :limit => 128
      t.string :constituent_country, :limit => 32
      t.decimal :price, :precision => 18, :scale => 6
      t.decimal :shares_per_basket, :precision => 18, :scale => 6
      t.decimal :number_shares, :precision => 18, :scale => 6
      t.column :sedol, 'character(7)'
    end
  end
end
