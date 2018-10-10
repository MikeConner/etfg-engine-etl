class AddSuppressionToPooledInstruments < ActiveRecord::Migration[5.2]
  def change
    add_column :pooled_instruments, :exclude_from_ts, :boolean, :null => false, :default => false
  end
end
