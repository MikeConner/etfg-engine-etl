class RequireSrcIdStagingIndustries < FeedMigrationBase[5.2]
  def up
    change_column :staging_industries, :datasource_id, :integer, :null => false
  end
  
  def down
    change_column :staging_industries, :datasource_id, :integer, :null => true
  end
end
