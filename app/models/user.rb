class User < ActiveRecord::Base
  has_many :statuses
  has_many :friendships
  has_many :friends, :through => :friendships
  
  attr_accessible :email, :name, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_uniqueness_of :name, :email
  validates :email, :email_format => true
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :name
  
  has_many :comments
  
  
  
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
      user.image_url = auth["user_info"]["image"]
    end
  end
end
