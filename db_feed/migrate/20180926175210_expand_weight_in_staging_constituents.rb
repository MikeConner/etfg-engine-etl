class ExpandWeightInStagingConstituents < FeedMigrationBase[5.2]
  def up
    change_column :staging_constituents, :weight, :decimal, :precision => 18, :scale => 10
  end
  
  def down
    change_column :staging_constituents, :weight, :decimal, :precision => 22, :scale => 6
  end
end
