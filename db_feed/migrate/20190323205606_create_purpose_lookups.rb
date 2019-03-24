class CreatePurposeLookups < FeedMigrationBase[5.2]
  def change
    create_table :purpose_lookups, :id => false do |t|
      t.string :account_number, :limit => 32
      t.string :ticker, :limit => 32
    end
    
    add_index :purpose_lookups, :account_number
  end
end
