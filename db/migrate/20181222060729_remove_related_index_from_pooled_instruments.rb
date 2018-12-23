class RemoveRelatedIndexFromPooledInstruments < ActiveRecord::Migration[5.2]
  def up
    remove_column :pooled_instruments, :related_index
    remove_column :pooled_instruments, :related_index_name
  end
  
  def down
    add_column :pooled_instruments, :related_index, :string, :limit => 50      
    add_column :pooled_instruments, :related_index_name, :string, :limit => 50      
  end
end
