class AddAssetClassToTsConstituents < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_constituents, :asset_class, :string, :limit => 28
  end
end
