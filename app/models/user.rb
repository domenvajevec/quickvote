require 'bcrypt'

class User

  include Mongoid::Document

  has_many :up_down_votes

  attr_accessor :password

  field :email, type: String
  field :salt, type: String
  field :hashed_password, type: String
  field :admin, type: String, default: "No"

  validates :email, uniqueness: true, presence: true

  before_save :hash_password

  def authenticated?(pwd)
  	self.hashed_password == BCrypt::Engine.hash_secret(pwd, self.salt)
  end

  private

  def hash_password
  	self.salt = BCrypt::Engine.generate_salt
  	self.hashed_password = BCrypt::Engine.hash_secret(self.password, self.salt)
  	self.password = nil
  end

end
