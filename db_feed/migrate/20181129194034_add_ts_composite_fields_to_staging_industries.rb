class AddTsCompositeFieldsToStagingIndustries < FeedMigrationBase[5.2]
  def change
    add_column :staging_industries, :nav, :decimal, :precision => 22, :scale => 6
    add_column :staging_industries, :aum, :decimal, :precision => 22, :scale => 6
  end
end
