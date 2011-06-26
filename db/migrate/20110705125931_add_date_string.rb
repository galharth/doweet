class AddDateString < ActiveRecord::Migration
  def self.up
    add_column :statuses, :date_string, :string
    remove_column :statuses, :status_date
  end

  def self.down
    remove_column :statuses, :date_string
    add_column :statuses, :status_date, :date
    
  end
end
