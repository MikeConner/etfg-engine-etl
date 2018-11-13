class CreateShortSqueezes < FeedMigrationBase[5.2]
  def change
    create_table :short_squeezes do |t|
      t.date :etfg_date, :null => false
      t.date :record_date, :null => false
      t.string :symbol, :null => false, :limit => 32
      t.string :company, :limit => 128
      t.decimal :total_short_interest, :precision => 18, :scale => 6
      t.decimal :days_to_cover, :precision => 18, :scale => 6
      t.decimal :short_pct_of_float, :precision => 18, :scale => 6
      t.decimal :short_prior_mo, :precision => 18, :scale => 6
    end
  end
end
