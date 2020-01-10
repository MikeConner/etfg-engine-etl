class AddIopvToPooledInstruments < ActiveRecord::Migration[5.2]
  def change
    add_column :pooled_instruments, :iopv_symbol, :string, :limit => 32
  end
end
