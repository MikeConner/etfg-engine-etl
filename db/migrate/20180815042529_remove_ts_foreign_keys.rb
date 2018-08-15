class RemoveTsForeignKeys < ActiveRecord::Migration[5.2]
  def up
    remove_foreign_key :ts_composites, :pooled_instruments
    change_column :ts_composites, :pooled_instrument_id, :integer, :limit => 8, :null => true
    change_column :ts_composites, :composite_name, :string, :limit => 128, :null => true

    remove_foreign_key :ts_constituents, :pooled_instruments
    remove_foreign_key :ts_constituents, :instruments
    change_column :ts_constituents, :pooled_instrument_id, :integer, :limit => 8, :null => true
    change_column :ts_constituents, :instrument_id, :integer, :limit => 8, :null => true
    change_column :ts_constituents, :composite_name, :string, :limit => 128, :null => true
    change_column :ts_constituents, :constituent_name, :string, :limit => 128, :null => true
  end
  
  def down
    add_foreign_key :ts_composites, :pooled_instruments
    change_column :ts_composites, :pooled_instrument_id, :integer, :limit => 8, :null => false    
    change_column :ts_composites, :composite_name, :string, :limit => 128, :null => false

    add_foreign_key :ts_constituents, :pooled_instruments
    add_foreign_key :ts_constituents, :instruments
    change_column :ts_constituents, :pooled_instrument_id, :integer, :limit => 8, :null => false
    change_column :ts_constituents, :instrument_id, :integer, :limit => 8, :null => false
    change_column :ts_constituents, :composite_name, :string, :limit => 128, :null => false
    change_column :ts_constituents, :constituent_name, :string, :limit => 128, :null => false
  end
end
