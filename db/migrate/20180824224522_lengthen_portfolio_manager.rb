class LengthenPortfolioManager < ActiveRecord::Migration[5.2]
  def up
    change_column :pooled_instruments, :portfolio_manager, :string
  end
  
  def down
    change_column :pooled_instruments, :portfolio_manager, :string, :limit => 128    
  end
end
