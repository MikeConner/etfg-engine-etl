class DatasourcesNavNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :datasources, :composite_rank, :integer, :default => 5, :null => true
  end

  def down
    change_column :datasources, :composite_rank, :integer, :default => 5, :null => false
  end
end
