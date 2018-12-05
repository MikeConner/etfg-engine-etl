class CreateEtprTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :etpr_templates do |t|
      t.string :template_file

      t.timestamps
    end
  end
end
