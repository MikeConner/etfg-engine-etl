class CreateXigniteApiCalls < FeedMigrationBase[5.2]
  def change
    create_table :xignite_api_calls, :id => false do |t|
      t.column :cusip, 'character(9)', :null => false
      t.string :industry, :limit => 64
      t.string :sector, :limit => 128
      t.text :data
    end
    
    add_index :xignite_api_calls, :cusip, :unique => true
  end
end
