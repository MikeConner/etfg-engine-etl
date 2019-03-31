class AddDefaultCountryToRegions < ActiveRecord::Migration[5.2]
  def change
    add_column :regions, :default_country, 'character(2)'
    remove_column :regions, :multi_country
  end
end
