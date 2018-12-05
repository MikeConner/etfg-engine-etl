# == Schema Information
#
# Table name: etpr_templates
#
#  id            :bigint(8)        not null, primary key
#  user_id       :bigint(8)
#  template_file :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class EtprTemplate < QcProcessSchemaBase
  belongs_to :user
  mount_uploader :template_file, WorkbenchFileUploader
end
