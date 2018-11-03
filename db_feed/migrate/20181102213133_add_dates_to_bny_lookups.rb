class AddDatesToBnyLookups < FeedMigrationBase[5.2]
  def change
    add_column :bny_lookups, :effective_date, :date
    add_column :bny_lookups, :expiration_date, :date
  end
end
