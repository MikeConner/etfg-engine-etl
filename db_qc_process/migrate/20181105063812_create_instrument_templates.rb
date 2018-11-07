class CreateInstrumentTemplates < QcProcessMigrationBase[5.2]
  def change
    create_table :instrument_templates do |t|
      t.references :user
      t.string :template_file

      t.timestamps
    end
  end
end
