class AddDatesToIssuers < ActiveRecord::Migration[5.2]
  def change
    add_column :issuers, :effective_date, :date
    add_column :issuers, :expiration_date, :date
  end
end
