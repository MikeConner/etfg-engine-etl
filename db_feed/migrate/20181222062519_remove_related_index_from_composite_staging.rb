class RemoveRelatedIndexFromCompositeStaging < FeedMigrationBase[5.2]
  def up
    remove_column :staging_composites, :related_index
    remove_column :staging_composites, :related_index_name
  end
  
  def down
    add_column :staging_composites, :related_index, :string, :limit => 50      
    add_column :staging_composites, :related_index_name, :string, :limit => 50          
  end
end
