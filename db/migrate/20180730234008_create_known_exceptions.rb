class CreateKnownExceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :known_exceptions do |t|
      t.integer :datasource_id, :limit => 2, :null => false
      t.date :effective_date
      t.date :expiration_date
      t.text :constituent_name, :null => false
      t.string :id_type, :limit => 8, :null => false
      t.string :id_value, :limit => 12, :null => false
      t.string :figi, :limit => 12
    end
    
    add_index :known_exceptions, :datasource_id
  end
end
