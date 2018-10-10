class CreateBnyLookups < FeedMigrationBase[5.2]
  def change
    create_table :bny_lookups, :id => false do |t|
      t.string :fund_id, :limit => 32
      t.string :account_name, :limit => 128
      t.string :ticker, :limit => 32
    end
  end
end
