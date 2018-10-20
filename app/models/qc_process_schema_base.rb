class QcProcessSchemaBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection QC_PROCESS_SCHEMA
end
