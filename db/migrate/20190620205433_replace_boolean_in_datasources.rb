class ReplaceBooleanInDatasources < ActiveRecord::Migration[5.2]
  def up
    remove_column :datasources, :is_direct_feed
    add_column :datasources, :source_type, :string, :limit => 16, :null => false, :default => Datasource::DIRECT_FEED
  end
  
  def down
    remove_column :datasources, :source_type  
    add_column :datasources, :is_direct_feed, :boolean, :null => false, :default => true
  end
end
