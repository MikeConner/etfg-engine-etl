class LengthAssetClass < ActiveRecord::Migration[5.2]
  def up
    change_column :ts_constituents, :asset_class, :string, :limit => 64
  end
  
  def down
    change_column :ts_constituents, :asset_class, :string, :limit => 28    
  end
end
