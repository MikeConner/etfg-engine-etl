class RenameCountryToRegion < ActiveRecord::Migration[5.2]
  def up
    rename_column :datasources, :country, :region
  end
  
  def down
    rename_column :datasources, :region, :country    
  end
end
