class AddCountryToDatasources < ActiveRecord::Migration[5.2]
  def change
    add_column :datasources, :country, 'character(2)', :null => false, :default => 'US'
  end
end
