class FeedMigrationBase < ActiveRecord::Migration[5.2] 
  def connection
    FeedSchemaBase.connection
  end
end
