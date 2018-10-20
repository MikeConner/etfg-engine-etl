class CreateJpmLookups < FeedMigrationBase[5.2]
  def change
    create_table :jpm_lookups, :id => false do |t|
      t.string :source, :limit => 16
      t.string :account_number, :limit => 32
      t.string :account_name, :limit => 128
      t.string :ticker, :limit => 32
    end
  end
end
