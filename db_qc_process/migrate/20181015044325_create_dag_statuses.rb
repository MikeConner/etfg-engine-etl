class CreateDagStatuses < QcProcessMigrationBase[5.2]
  def change
    create_table :dag_statuses do |t|
      t.string :datasource, :limit => 32, :null => false
      t.date :etfg_date, :null => false
      t.string :process, :limit => 64, :null => false
      t.string :status, :limit => 128, :null => false
      t.boolean :completed, :null => false, :default => false
      t.date :updated_at
    end
  end
end
