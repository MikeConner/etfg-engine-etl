class SplitRankings < ActiveRecord::Migration[5.2]
  def up
    change_column :datasource_ranks, :composite_ticker, :string, :limit => 32, :null => false
    add_column :datasource_ranks, :composite, :boolean
  end
  
  def down
    remove_column :datasource_ranks, :composite
  end
end
