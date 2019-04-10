class CreateEtprLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :etpr_logs do |t|
      t.date :upload_date, :null => false
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :exchange_country, :null => false, :limit => 64
      t.text :result, :null => false

      t.timestamps
    end
  end
end
