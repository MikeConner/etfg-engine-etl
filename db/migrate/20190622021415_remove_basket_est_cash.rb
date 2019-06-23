class RemoveBasketEstCash < ActiveRecord::Migration[5.2]
  def up
    remove_column :ts_composites, :basket_estimated_cash
  end
  
  def down
    add_column :ts_composites, :basket_estimated_cash, :decimal, :precision => 22, :scale => 6    
  end
end
