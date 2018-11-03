class DropCompIdTable < FeedMigrationBase[5.2]
  def up
    drop_table :df_composite_identifiers
  end
  
  def down
    create_table :df_composite_identifiers, :id => false do |t|
      t.integer :datasource_id, :limit => 2, :null => false
      t.string :ticker, :null => false, :limit => 32
      t.string :name, :limit => 128
      t.column :figi, 'character(12)', :null => false
      t.boolean :composite_figi, :null => false, :default => true
      t.column :sedol, 'character(7)'
      t.column :isin, 'character(12)'
      t.column :cusip, 'character(9)'
      t.column :secid, 'character(12)'
    end
    
    add_index :df_composite_identifiers, :ticker
    add_index :df_composite_identifiers, :figi, :unique => true
    add_index :df_composite_identifiers, [:datasource_id, :ticker], :unique => true    
  end
end
