class AddSourceNameToVanguardEtfs < FeedMigrationBase[5.2]
  def change
    add_column :vanguard_etfs, :source_name, :string, :limit => 32
  end
end
