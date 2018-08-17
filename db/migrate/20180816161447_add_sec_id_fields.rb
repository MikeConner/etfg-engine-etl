class AddSecIdFields < ActiveRecord::Migration[5.2]
  def change
    add_column :instruments, :secid, 'character(12)'
    add_column :pooled_instruments, :secid, 'character(12)'
  end
end
