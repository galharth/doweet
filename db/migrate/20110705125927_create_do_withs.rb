class CreateDoWiths < ActiveRecord::Migration
  def self.up
    create_table :do_withs do |t|
      t.integer :status_id 
      t.integer :friend_id
      t.timestamps
    end
  end

  def self.down
    drop_table :do_withs
  end
end
