class Addgoupname < ActiveRecord::Migration
  def self.up 
  	add_column :statuses , :group, :string
  end

  def self.down
    remove_column :statuses, :group ,
  end
end
