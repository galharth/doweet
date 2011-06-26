class AddProfileImage < ActiveRecord::Migration
  def self.up
    add_column :users, :image_url, :string, :default => "/images/profilephoto.png"
  end

  def self.down
    remove_column :users, :image_url
  end
end
