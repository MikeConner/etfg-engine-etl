class CreateCompositeFigis < ActiveRecord::Migration[5.2]
  def change
    create_table :composite_figis do |t|
      t.string :figi, :limit => 12, :null => false
      t.string :composite_figi, :limit => 12, :null => false
      t.datetime :created_at, :null => false, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :ticker, :limit => 64
      t.string :name, :limit => 128
      t.string :security_type, :limit => 128
      t.string :market_sector, :limit => 128
      t.string :exchange_code, :limit => 32
      t.string :unique_id, :limit => 32
      t.string :description
      t.string :iso_country, :limit => 2
    end
    
    add_index :composite_figis, [:figi, :composite_figi], :unique => true, :name => 'no_figi_map_dups'
    add_index :composite_figis, :figi
    add_index :composite_figis, :composite_figi
  end
end
