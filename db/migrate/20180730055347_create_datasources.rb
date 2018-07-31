class CreateDatasources < ActiveRecord::Migration[5.2]
  def change
    create_table :datasources do |t|
      t.string :data_source_name, :limit => 50, :null => false
    end
  end
end
