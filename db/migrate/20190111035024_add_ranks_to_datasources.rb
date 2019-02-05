class AddRanksToDatasources < ActiveRecord::Migration[5.2]
  def change
    add_column :datasources, :composite_rank, :integer, :limit => 2, :null => false, :default => 5
    add_column :datasources, :constituent_rank, :integer, :limit => 2, :default => 5
  end
end
