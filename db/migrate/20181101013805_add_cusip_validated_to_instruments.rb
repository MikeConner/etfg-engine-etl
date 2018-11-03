class AddCusipValidatedToInstruments < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :cusip_validated, :string, :limit => 16
  end
end
