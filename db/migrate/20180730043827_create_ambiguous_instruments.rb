class CreateAmbiguousInstruments < ActiveRecord::Migration[5.2]
  def change
    create_table :ambiguous_instruments do |t|
      t.integer :datasource_id, :limit => 2, :null => false
      t.date :file_date, :null => false
      t.integer :datasource_line, :limit => 8, :null => false
      t.text :instrument_list, :null => false
      t.integer :resolved_id, :limit => 8
    end
    
    add_index :ambiguous_instruments, [:datasource_id, :file_date, :datasource_line], :unique => true, :name => 'no_dups_ambigs'
    add_index :ambiguous_instruments, [:datasource_id, :file_date], :name => 'speed_up_ambigs'
  end
end
