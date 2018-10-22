class AddSkippedToPooledInstrumentExceptions < ActiveRecord::Migration[5.2]
  def change
    add_column :pooled_instrument_exceptions, :skipped, :boolean, :null => false, :default => false
  end
end
