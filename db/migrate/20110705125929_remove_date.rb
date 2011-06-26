class RemoveDate < ActiveRecord::Migration
  def self.up
	remove_column :statuses, :due_date
  	add_column  :statuses , :status_date, :date 
  end

  def self.down
	add_column :statuses, :due_date, :date

  	remove_column :statuses , :status_date 
  end
end
 