class AddIndexToTsConstituents < ActiveRecord::Migration[5.2]
  def change
    add_index :ts_constituents, [:etfg_date, :pooled_instrument_id, :instrument_id], :name => 'index_on_date_indices'
  end
end
