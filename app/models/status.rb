class Status < ActiveRecord::Base
  
has_many :comments
belongs_to :user
has_many :do_withs
has_many :likes


validates :content, :date, :presence => true



end
