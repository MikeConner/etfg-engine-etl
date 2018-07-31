class CreatePooledInstrumentExceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :pooled_instrument_exceptions do |t|
      t.integer :datasource_id, :limit => 2, :null => false
      t.date :file_date, :null => false
      t.integer :pooled_instrument_id, :limit => 8, :null => false
      t.string :name_in_datasource, :limit => 128, :null => false
      t.text :datasource_lines, :null => false
    end
    
    add_index :pooled_instrument_exceptions, [:datasource_id, :file_date, :pooled_instrument_id, :name_in_datasource], 
              :unique => true, :name => 'no_dups_piexc'
  end
end
