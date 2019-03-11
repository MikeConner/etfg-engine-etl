class CreateHorizonLookups < FeedMigrationBase[5.2]
  def change
    create_table :horizon_lookups, :id => false do |t|
      t.string :account, :null => false, :limit => 32
      t.string :fund_ticker, :null => false, :limit => 32
      t.string :fund_name, :null => false, :limit => 128
    end
    
    add_index :horizon_lookups, :account, :unique => true
  end
end
