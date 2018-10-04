class AddIdsToPooledInstruments < ActiveRecord::Migration[5.2]
  def up
    add_column :pooled_instruments, :figi, 'char(12)'
    add_column :pooled_instruments, :is_exchange_figi, :boolean, :null => false, :default => false
    add_column :pooled_instruments, :sedol, 'char(7)'
    add_column :pooled_instruments, :isin, 'char(12)'
    add_column :pooled_instruments, :cusip, 'char(9)'
    add_column :pooled_instruments, :datasource_id, :integer
    
    drop_table :pooled_instrument_overwrites
  end
  
  def down
    remove_column :pooled_instruments, :figi
    remove_column :pooled_instruments, :is_exchange_figi
    remove_column :pooled_instruments, :sedol
    remove_column :pooled_instruments, :isin
    remove_column :pooled_instruments, :cusip
    remove_column :pooled_instruments, :datasource_id
    
    create_table :pooled_instrument_overwrites do |t|
      t.integer :instrument_id, :limit => 8, :null => false
      t.integer :previous_composite_id, :limit => 8, :null => false
      t.integer :current_composite_id, :limit => 8, :null => false
      t.integer :datasource_id, :limit => 2, :null => false
      t.date :file_date, :null => false
      t.integer :datasource_line, :limit => 8, :null => false      
    end    
  end
end
