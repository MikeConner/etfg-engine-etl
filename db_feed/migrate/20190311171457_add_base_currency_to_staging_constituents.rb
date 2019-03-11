class AddBaseCurrencyToStagingConstituents < FeedMigrationBase[5.2]
  def change
    add_column :staging_constituents, :base_currency, :string, :limit => 16
  end
end
