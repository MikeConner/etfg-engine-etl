class AddRegionToTsExposures < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_exposures, :region, 'character(2)'  
    
    add_index :ts_exposures, :region
  end  
end
