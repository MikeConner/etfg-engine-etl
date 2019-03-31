class CreateCompositeCountryOverrides < ActiveRecord::Migration[5.2]
  def change
    create_table :composite_country_overrides do |t|
      t.references :datasource, :null => false
      t.string :composite_ticker, :limit => 32, :null => false
      t.column :composite_country, 'character(2)', :null => false
    end
    
    add_index :composite_country_overrides, [:datasource_id, :composite_country], :unique => true, :name => 'index_on_id_country'
  end
end
