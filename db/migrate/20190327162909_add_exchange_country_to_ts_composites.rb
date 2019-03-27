class AddExchangeCountryToTsComposites < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_composites, :exchange_country, :string, :limit => 64
    add_column :ts_constituents, :exchange_country, :string, :limit => 64
  end
end
