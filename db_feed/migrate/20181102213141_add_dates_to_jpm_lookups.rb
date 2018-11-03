class AddDatesToJpmLookups < FeedMigrationBase[5.2]
  def change
    add_column :jpm_lookups, :effective_date, :date
    add_column :jpm_lookups, :expiration_date, :date
  end
end
