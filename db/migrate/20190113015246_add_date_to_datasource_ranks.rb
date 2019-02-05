class AddDateToDatasourceRanks < ActiveRecord::Migration[5.2]
  def change
    add_column :datasource_ranks, :etfg_date, :date
  end
end
