class CreateInstrumentExceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :instrument_exceptions do |t|
      t.integer :datasource_id, :limit => 2, :null => false
      t.date :file_date, :null => false
      t.integer :instrument_id, :limit => 8, :null => false
      t.string :name_in_datasource, :limit => 128, :null => false
      t.text :datasource_lines, :null => false
    end
    
    add_index :instrument_exceptions, :datasource_id
    add_index :instrument_exceptions, :instrument_id
    add_index :instrument_exceptions, [:datasource_id, :file_date], :name => 'idx_data_on_date'
  end
end
