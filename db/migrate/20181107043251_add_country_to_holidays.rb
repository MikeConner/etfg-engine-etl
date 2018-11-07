class AddCountryToHolidays < ActiveRecord::Migration[5.2]
  def up
    drop_table :holidays
    
    create_table :holidays do |t|
      t.column :country, 'character(2)', :null => false, :default => 'US'
      t.date :market_day, :null => false
      t.boolean :is_open, :null => false
      t.string :description
    end
  end
  
  def down
    drop_table :holidays
    
    create_table :holidays, :id => false do |t|
      t.date :market_day, :null => false
      t.boolean :is_open, :null => false
      t.string :description
    end    
  end
end
