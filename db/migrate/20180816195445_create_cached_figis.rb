class CreateCachedFigis < ActiveRecord::Migration[5.2]
  def change
    create_table :cached_figis do |t|
      t.string :input_ids, :null => false
      t.date :last_updated
    end
    
    add_index :cached_figis, :input_ids, :unique => true
  end
end
