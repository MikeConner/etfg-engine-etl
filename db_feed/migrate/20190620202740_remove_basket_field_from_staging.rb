class RemoveBasketFieldFromStaging < FeedMigrationBase[5.2]
  def up
    remove_column :staging_composites, :basket_estimated_cash
  end
  
  def down
   add_column :staging_composites, :basket_estimated_cash, :decimal, :precision => 22, :scaling => 6  
  end
end
