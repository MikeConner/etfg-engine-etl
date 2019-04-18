class CreateFirstAssetFunds < FeedMigrationBase[5.2]
  def change
    create_table :first_asset_funds, :id => false do |t|
      t.string :ticker, :null => false, :limit => 4
      t.string :fund_name, :limit => 128
      t.string :address, :null => false
    end
    
    add_index :first_asset_funds, :ticker, :unique => true
  end
end
