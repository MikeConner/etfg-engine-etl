class ExtendCompositeDescription < ActiveRecord::Migration[5.2]
  def up
    change_column :pooled_instruments, :composite_description, :string
  end
  
  def down
    change_column :pooled_instruments, :composite_description, :string, :limit => 128    
  end
end
