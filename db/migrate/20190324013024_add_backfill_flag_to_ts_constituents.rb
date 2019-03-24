class AddBackfillFlagToTsConstituents < ActiveRecord::Migration[5.2]
  def change
    add_column :ts_constituents, :backfill_flag, :boolean, :null => false, :default => false
  end
end
