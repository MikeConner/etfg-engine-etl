class AddCurrencyIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :instruments, :currency
  end
end
