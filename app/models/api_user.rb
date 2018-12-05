# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  username           :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :inet
#  last_sign_in_ip    :inet
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ApiUser < ApiSchemaBase
  self.table_name = "users"
  
  has_and_belongs_to_many :actions, :foreign_key => 'user_id'
  
  def has_permission(enum)
    actions.map(&:description).include?(enum.to_s)
  end
end
