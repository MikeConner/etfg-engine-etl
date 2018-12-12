class CreateCountryMaps < ActiveRecord::Migration[5.2]
  def up
    create_table :country_maps, :id => false do |t|
      t.string :country, :limit => 64, :null => false, :unique => true
      t.column :iso_a2_code, 'character(2)'
      t.column :iso_a3_code, 'character(3)'
    end
    
    change_column :instruments, :geography, :string, :limit => 3
  end
  
  def down
    drop_table :country_maps
    change_column :instruments, :geography, 'character(2)'    
  end
end
