class AddColumnsToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :week_num, :integer
    add_column :statuses, :day_name, :string
  end

  def self.down
    remove_column :statuses, :week_num
    remove_column :statuses, :day_name
  end
end
