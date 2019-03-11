class AddBaseCurrencyToTsConstituents < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_constituents, :base_currency, :string, :limit => 16
  end
end
