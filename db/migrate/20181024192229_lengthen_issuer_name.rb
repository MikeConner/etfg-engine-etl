class LengthenIssuerName < ActiveRecord::Migration[5.2]
  def up
    change_column :pooled_instruments, :issuer, :string, :limit => 64
  end
  
  def down
    change_column :pooled_instruments, :issuer, :string, :limit => 32    
  end
end
