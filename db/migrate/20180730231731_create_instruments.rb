class CreateInstruments < ActiveRecord::Migration[5.2]
  def change
    create_table :instruments do |t|
      t.integer :issuer_id
      t.string :issuer, :limit => 32
      t.string :ticker, :limit => 64
      t.text :name_variants, :null => false
      t.date :effective_date
      t.date :expiration_date
      t.string :figi, :limit => 12, :null => false
      t.boolean :is_exchange_figi, :null => false, :default => false
      t.string :sedol, :limit => 7
      t.string :isin, :limit => 12
      t.string :cusip, :limit => 9
      t.string :exchange_country, :limit => 64
      t.string :currency, :limit => 16
      t.string :exchange, :limit => 64
      t.string :market_sector, :limit => 128
      t.string :security_type, :limit => 128
      t.string :sector, :limit => 64
      t.string :industry, :limit => 64
      t.string :master_guid, :limit => 36
      t.string :industry_group, :limit => 128
      t.string :subindustry, :limit => 128
      t.string :rating, :limit => 32
      t.boolean :approved, :null => false, :default => false
      t.boolean :is_valid, :null => false, :default => false
      t.boolean :default_instrument, :null => false, :default => false
      t.datetime :created_at, :null => false, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :standard_name, :limit => 128
      t.integer :pooled_instrument_id, :limit => 8
      t.integer :instrument_id, :limit => 8
    end
    
    add_index :instruments, :issuer_id
    add_index :instruments, :pooled_instrument_id
    add_index :instruments, :cusip
    add_index :instruments, :isin
    add_index :instruments, :sedol
    add_index :instruments, :figi
  end
end
