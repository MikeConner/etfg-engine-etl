class CreateUnmatchedSources < ActiveRecord::Migration[5.2]
  def change
    create_table :unmatched_sources, :id => false do |t|
      t.date :etfg_date
      t.integer :datasource_id
      t.boolean :composite
    end
    
    add_index :unmatched_sources, [:etfg_date, :datasource_id, :composite], :name => 'uid_unmatched_sources', :unique => true
  end
end
