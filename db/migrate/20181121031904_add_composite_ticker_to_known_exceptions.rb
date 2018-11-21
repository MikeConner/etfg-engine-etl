class AddCompositeTickerToKnownExceptions < ActiveRecord::Migration[5.2]
  def change
    add_column :known_exceptions, :composite_ticker, :string, :limit => 32
  end
end
