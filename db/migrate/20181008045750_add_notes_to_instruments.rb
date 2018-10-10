class AddNotesToInstruments < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :notes, :text
  end
end
