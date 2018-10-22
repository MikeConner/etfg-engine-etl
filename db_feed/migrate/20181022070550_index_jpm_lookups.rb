class IndexJpmLookups < FeedMigrationBase[5.2]
  def up
    drop_table :jpm_lookups
    
    create_table :jpm_lookups do |t|
      t.string :source, :limit => 16, :null => false
      t.string :account_number, :limit => 32, :null => false
      t.string :account_name, :limit => 128
      t.string :ticker, :limit => 32, :null => false
    end
    
    add_index :jpm_lookups, [:source, :account_number], :unique => true
  end
  
  def down
    drop_table :jpm_lookups
    
    create_table :jpm_lookups, :id => false do |t|
      t.string :source, :limit => 16
      t.string :account_number, :limit => 32
      t.string :account_name, :limit => 128
      t.string :ticker, :limit => 32
    end
  end
end
