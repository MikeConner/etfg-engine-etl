class AddDatesToIssuerVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :issuer_variants, :effective_date, :date
    add_column :issuer_variants, :expiration_date, :date
  end
end
