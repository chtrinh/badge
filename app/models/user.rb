require 'digest/sha2'

class User
  include MongoMapper::Document
  
  key :_id , String
  key :name, String
  key :email,  String
  key :admin, Boolean, :default => false
  key :password_hash, String
  key :password_salt, String

  key :friendship_id, String
  belongs_to :friendship, :dependent => :destroy 
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence => true
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => true
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :minimum => 6 }
                       
  before_save :make_secret
  
  def has_password?(submitted_password)
    password_hash == encrypt(submitted_password)
  end
  
  def self.auth(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(password)
  end
  
  
  private 
  def make_secret
    self.password_salt = make_salt if new_record?
    self.password_hash = encrypt(self.password)
  end
  
  def encrypt(string)
    Digest::SHA2.hexdigest(string + self.password_salt)
  end
  
  def make_salt
   [Array.new(6){rand(256).chr}.join].pack("m").chomp
  end
end