class AddAllIdIndexOnInstruments < ActiveRecord::Migration[5.2]
  def change
    add_index :instruments, [:figi, :sedol, :isin, :cusip], :name => 'all_indexes_instruments'
  end
end
