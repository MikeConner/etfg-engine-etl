class CreateTsExposures < ActiveRecord::Migration[5.2]
  def up
    create_table :ts_exposures do |t|
      t.date :etfg_date, :null => false
      t.date :as_of_date, :null => false
      t.integer :pooled_instrument_id, :limit => 8, :null => false
      t.string :exposure_type, :null => false, :limit => 64
      t.string :category, :null => false, :limit => 64
      t.decimal :exposure_value, :null => false, :precision => 22, :scale => 6
    end
    
    add_index :ts_exposures, :etfg_date
    add_index :ts_exposures, :pooled_instrument_id
    add_index :ts_exposures, [:etfg_date, :exposure_type]
    
    drop_table :pooled_instrument_overwrites
  end
  
  def down
    create_table :pooled_instrument_overwrites do |t|
      t.integer :instrument_id, :limit => 8, :null => false
      t.integer :previous_composite_id, :limit => 8, :null => false
      t.integer :current_composite_id, :limit => 8, :null => false
      t.integer :datasource_id, :limit => 2, :null => false
      t.date :file_date, :null => false
      t.integer :datasource_line, :limit => 8, :null => false      
    end    
    
    drop_table :ts_exposures
  end
end
