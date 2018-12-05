class CreateEtprTemplates < QcProcessMigrationBase[5.2]
  def change
    create_table :etpr_templates do |t|
      t.references :user
      t.string :template_file

      t.timestamps
    end
  end
end
