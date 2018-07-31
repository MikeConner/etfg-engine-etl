class CreateIssuerExceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :issuer_exceptions do |t|
      t.integer :datasource_id, :limit => 2, :null => false
      t.date :file_date, :null => false
      t.string :tablename, :limit => 64, :null => false
      t.string :name_in_datasource, :limit => 128
    end
    
    add_index :issuer_exceptions, [:datasource_id, :name_in_datasource], :unique => true
    add_index :issuer_exceptions, [:datasource_id, :file_date]
    add_index :issuer_exceptions, :datasource_id
  end
end
