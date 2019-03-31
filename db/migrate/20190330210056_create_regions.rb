class CreateRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :regions, :id => false do |t|
      t.column :region_name, 'character(2)', :null => false
      t.boolean :multi_country, :null => false
    end
  
    add_index :regions, :region_name, :unique => true
  end
end
