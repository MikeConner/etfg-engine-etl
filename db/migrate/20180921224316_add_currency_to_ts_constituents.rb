class AddCurrencyToTsConstituents < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_constituents, :currency, "char(3)"
  end
end
