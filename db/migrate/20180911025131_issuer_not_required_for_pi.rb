class IssuerNotRequiredForPi < ActiveRecord::Migration[5.2]
  def up
    change_column :pooled_instruments, :issuer, :string, :limit => 32, :null => true
  end
  
  def down
    change_column :pooled_instruments, :issuer, :string, :limit => 32, :null => false    
  end
end
