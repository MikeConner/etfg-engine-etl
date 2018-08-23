class AddAsOfDateToTs < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_composites, :as_of_date, :date, :null => false
    add_column :ts_constituents, :as_of_date, :date, :null => false
  end
end
