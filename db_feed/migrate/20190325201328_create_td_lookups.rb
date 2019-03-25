class CreateTdLookups < FeedMigrationBase[5.2]
  def change
    create_table :td_lookups, :id => false do |t|
      t.string :ticker, :limit => 32
      t.string :account_number, :limit => 32
    end
  end
end
