class AddPrivateToStatus < ActiveRecord::Migration
  def self.up
  	add_column :statuses , :private , :boolean, :default => false 
  end

  def self.down
  	remove_column :statuses , :private
  end
end
