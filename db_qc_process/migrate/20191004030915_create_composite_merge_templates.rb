class CreateCompositeMergeTemplates < QcProcessMigrationBase[5.2]
  def change
    create_table :composite_merge_templates do |t|
      t.references :user
      t.string :template_file

      t.timestamps
    end
  end
end
