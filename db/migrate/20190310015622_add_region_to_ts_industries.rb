class AddRegionToTsIndustries < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_industries, :output_region, 'character(2)'
    
    add_index :ts_industries, :output_region
  end
end
