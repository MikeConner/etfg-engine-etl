class CreateHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :holidays, :id => false do |t|
      t.date :market_day, :null => false
      t.boolean :is_open, :null => false
      t.string :description
    end
  end
end
