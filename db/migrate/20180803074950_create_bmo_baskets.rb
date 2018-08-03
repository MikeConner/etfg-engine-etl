class CreateBmoBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :bmo_baskets do |t|
      # Section 1
      t.string :fund_ticker
      t.string :fund_account_number
      t.string :fund_name
      t.decimal :units_outstanding
      t.decimal :nav
      t.decimal :project_cash_amount
      t.decimal :dist_price_adj
      t.decimal :fx_rate
      t.decimal :mer
      t.integer :prescribed_number_of_units
      t.decimal :caf

      # Section 2
      t.string :name
      t.string :ticker
      t.integer :shares_per_basket
      t.decimal :price
      t.integer :number_of_shares
      t.string :sedol

      t.date :etfg_date
    end
  end
end
