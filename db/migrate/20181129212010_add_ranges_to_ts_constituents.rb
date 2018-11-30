class AddRangesToTsConstituents < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_constituents, :coupon_range, :string, :limit => 8
    add_column :ts_constituents, :years_to_maturity, :integer, :limit => 2
    add_column :ts_constituents, :maturity_range, :string, :limit => 8
  end
end
