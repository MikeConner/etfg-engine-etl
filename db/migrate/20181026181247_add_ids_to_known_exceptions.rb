class AddIdsToKnownExceptions < ActiveRecord::Migration[5.2]
  def up
    remove_column :known_exceptions, :figi
    
    KnownException.reset_column_information
    
    add_column :known_exceptions, :country, :string, :limit => 64
    add_column :known_exceptions, :currency, :string, :limit => 16
    add_column :known_exceptions, :figi, 'character(12)'
    add_column :known_exceptions, :sedol, 'character(7)'
    add_column :known_exceptions, :isin, 'character(12)'
    add_column :known_exceptions, :cusip, 'character(9)'
  end
  
  def down
    remove_column :known_exceptions, :country
    remove_column :known_exceptions, :currency
    remove_column :known_exceptions, :sedol
    remove_column :known_exceptions, :isin
    remove_column :known_exceptions, :cusip
  end
end
