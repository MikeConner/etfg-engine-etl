class AddDatasourceIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :ts_constituents, :datasource_id
  end
end
