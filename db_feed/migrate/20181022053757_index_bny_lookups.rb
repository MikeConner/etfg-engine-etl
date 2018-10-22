class IndexBnyLookups < FeedMigrationBase[5.2]
  def change
    change_column :bny_lookups, :fund_id, :string, :limit => 32, :null => false
    change_column :bny_lookups, :account_name, :string, :limit => 128, :null => false
    change_column :bny_lookups, :ticker, :string, :limit => 32, :null => false
    
    add_index :bny_lookups, :fund_id, :unique => true
  end
end
