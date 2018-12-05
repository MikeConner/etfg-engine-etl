class AddGeographyToInstruments < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :geography, 'character(2)'
  end
end
