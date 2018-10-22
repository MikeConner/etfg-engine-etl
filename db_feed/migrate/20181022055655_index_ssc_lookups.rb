class IndexSscLookups < FeedMigrationBase[5.2]
  def up
    drop_table :ssc_lookups
    
    create_table :ssc_lookups do |t|
      t.column :fund_id, 'character(4)', :null => false
      t.string :fund_name, :limit => 128
      t.string :ticker, :limit => 32, :null => false
      t.date :effective_date
      t.date :expiration_date
      t.column :fund_id_alias, 'character(4)'
    end    
  end
  
  def down
    drop_table :ssc_lookups
    
    create_table :ssc_lookups, :id => false do |t|
      t.column :fund_id, 'character(4)'
      t.string :fund_name, :limit => 128
      t.string :ticker, :limit => 32
      t.date :effective_date
      t.date :expiration_date
      t.column :fund_id_alias, 'character(4)'
    end    
  end
end
