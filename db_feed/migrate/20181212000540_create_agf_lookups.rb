class CreateAgfLookups < FeedMigrationBase[5.2]
  def change
    create_table :agf_lookups, :id => false do |t|
      t.string :ticker, :null => false, :limit => 32, :unique => true
      t.string :holdings_name, :null => false, :limit => 128
      t.string :nav_name, :null => false, :limit => 128
    end
  end
end
