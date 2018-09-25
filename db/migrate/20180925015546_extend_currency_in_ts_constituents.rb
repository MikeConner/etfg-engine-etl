class ExtendCurrencyInTsConstituents < ActiveRecord::Migration[5.2]
  def up
    change_column :ts_constituents, :currency, :string, :limit => 16
  end
  
  def down
    change_column :ts_constituents, :currency, 'char(3)'  
  end
end
