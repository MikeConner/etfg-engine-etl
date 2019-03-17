class AddIndicesToTsTables < ActiveRecord::Migration[5.2]
  def change
    add_index :ts_industries, :etfg_date
    add_index :ts_exposures, :etfg_date
    add_index :ts_exposures, :exposure_type
  end
end
