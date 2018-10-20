class AddCouponMaturityToTsConstituents < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_constituents, :coupon, :decimal, :precision => 22, :scale => 6
    add_column :ts_constituents, :maturity_date, :date
  end
end
