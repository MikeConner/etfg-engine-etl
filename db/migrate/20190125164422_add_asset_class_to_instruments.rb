class AddAssetClassToInstruments < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :asset_class, :string, :limit => 128
  end
end
