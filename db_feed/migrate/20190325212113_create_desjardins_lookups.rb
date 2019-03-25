class CreateDesjardinsLookups < FeedMigrationBase[5.2]
  def change
    create_table :desjardins_lookups, :id => false do |t|
      t.string :fund_code, :limit => 32
      t.string :ticker, :limit => 32
    end
  end
end
