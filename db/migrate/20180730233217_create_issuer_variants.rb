class CreateIssuerVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :issuer_variants do |t|
      t.string :name, :limit => 32, :null => false
      t.integer :datasource_id, :limit => 2, :null => false
      t.integer :issuer_id
    end
    
    add_index :issuer_variants, [:name, :issuer_id], :unique => true
    add_index :issuer_variants, :datasource_id
    add_index :issuer_variants, :name
  end
end
