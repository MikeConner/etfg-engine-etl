class CreateBarclaysEtnsEod < FeedMigrationBase[5.2]
  def change
    create_table :barclays_etns_eod do |t|
      t.string :cusip
      t.string :isin
      t.string :ticker
      t.date :date
      t.string :name
      t.decimal :indicative_value
      t.integer :shares_outstanding
      t.decimal :index_value
      t.decimal :coupon
      t.decimal :market_capitalization
      t.date :etfg_date
    end
  end
end
