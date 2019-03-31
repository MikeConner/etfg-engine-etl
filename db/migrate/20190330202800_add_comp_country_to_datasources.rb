class AddCompCountryToDatasources < ActiveRecord::Migration[5.2]
  def change
    add_column :datasources, :composite_country, 'character(2)'
  end
end
