class AddDatasourceIdToInstruments < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :datasource_id, :integer
  end
end
