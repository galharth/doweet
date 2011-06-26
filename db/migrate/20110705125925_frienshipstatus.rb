class Frienshipstatus < ActiveRecord::Migration
  def self.up
  	add_column :friendships , :status , :boolean , :default =>  nil
  end
  
  def self.down
  	remove_column  :friendships , :status 
  end
end
