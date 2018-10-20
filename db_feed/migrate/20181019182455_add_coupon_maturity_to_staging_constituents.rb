class AddCouponMaturityToStagingConstituents < FeedMigrationBase[5.2]
  def change
    add_column :staging_constituents, :coupon, :decimal, :precision => 22, :scale => 6
    add_column :staging_constituents, :maturity_date, :date
  end
end
