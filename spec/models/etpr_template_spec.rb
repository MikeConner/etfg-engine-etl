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

require 'rails_helper'

RSpec.describe EtprTemplate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
