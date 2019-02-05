class CreateAssetClassLookups < FeedMigrationBase[5.2]
  def change
    create_table :asset_class_lookups do |t|
      t.string :security_type
      t.string :asset_class, :limit => 128
    end
  end
end
