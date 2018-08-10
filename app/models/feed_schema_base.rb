class FeedSchemaBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection FEED_SCHEMA
end
