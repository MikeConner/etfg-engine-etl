class ApiSchemaBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection API_SCHEMA
end
