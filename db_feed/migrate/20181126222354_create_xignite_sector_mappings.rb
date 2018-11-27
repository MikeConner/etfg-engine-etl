class CreateXigniteSectorMappings < FeedMigrationBase[5.2]
  def change
    create_table :xignite_sector_mappings, :id => false do |t|
      t.string :source, :null => false, :limit => 64
      t.string :dest, :null => false, :limit => 64
    end
  end
end
