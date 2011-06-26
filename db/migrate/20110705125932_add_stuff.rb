class AddStuff < ActiveRecord::Migration
  def self.up
    add_column :statuses, :date_string, :string
  	add_column :friendships , :status , :boolean , :default =>  nil
  end

  def self.down
    remove_column :statuses, :date_string
  	remove_column :friendships , :status 
  end
end
