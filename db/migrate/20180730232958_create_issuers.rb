class CreateIssuers < ActiveRecord::Migration[5.2]
  def change
    create_table :issuers do |t|
      t.string :name, :limit => 32, :null => false
    end
    
    add_index :issuers, :name, :unique => true
  end
end
