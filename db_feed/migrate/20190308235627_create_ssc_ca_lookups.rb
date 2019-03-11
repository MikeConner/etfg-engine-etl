class CreateSscCaLookups < FeedMigrationBase[5.2]
  def change
    create_table :ssc_ca_lookups, :id => false do |t|
      t.string :code, :null => false, :limit => 32
      t.string :ticker, :null => false, :limit => 32
      t.string :fund_name, :null => false, :limit => 128
   end
    
    add_index :ssc_ca_lookups, :code, :unique => true
  end
end
