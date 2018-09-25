class AddDatesToSscLookups < FeedMigrationBase[5.2]
  def change
    add_column :ssc_lookups, :effective_date, :date
    add_column :ssc_lookups, :expiration_date, :date
  end
end
