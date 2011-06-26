class AddTime < ActiveRecord::Migration
  def self.up
  	add_column :statuses , :due_time , :time 
  end

  def self.down
  	remove_column  :statuses , :due_time 
  end
end
