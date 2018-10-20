class QcProcessMigrationBase < ActiveRecord::Migration[5.2] 
  def connection
    QcProcessSchemaBase.connection
  end
end
