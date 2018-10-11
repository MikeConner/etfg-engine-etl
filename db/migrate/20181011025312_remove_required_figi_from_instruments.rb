class RemoveRequiredFigiFromInstruments < ActiveRecord::Migration[5.2]
  def up
    change_column :instruments, :figi, 'character(12)', :null => true
    change_column :instruments, :is_exchange_figi, :boolean, :null => true, :default => nil
  end
  
  def down
    change_column :instruments, :figi, 'character(12)', :null => false
    change_column :instruments, :is_exchange_figi, :boolean, :null => false, :default => false    
  end
end
