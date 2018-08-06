class AddIsDirectFeedToDatasources < ActiveRecord::Migration[5.2]
  def change
    add_column :datasources, :is_direct_feed, :boolean, :null => false, :default => true
  end
end
