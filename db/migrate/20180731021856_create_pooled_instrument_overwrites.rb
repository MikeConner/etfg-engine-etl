class CreatePooledInstrumentOverwrites < ActiveRecord::Migration[5.2]
  def change
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
