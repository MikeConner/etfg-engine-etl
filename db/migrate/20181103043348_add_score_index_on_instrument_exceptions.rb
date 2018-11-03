class AddScoreIndexOnInstrumentExceptions < ActiveRecord::Migration[5.2]
  def change
    add_index :instrument_exceptions, :score
    add_index :instrument_exceptions, [:score, :end_date]
  end
end
