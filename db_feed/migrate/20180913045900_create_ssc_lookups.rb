class CreateSscLookups < FeedMigrationBase[5.2]
  def change
    create_table :ssc_lookups, :id => false do |t|
      t.column :fund_id, 'character(4)'
      t.string :fund_name, :limit => 128
      t.string :ticker, :limit => 32
    end
  end
end
