require 'bcrypt'

class User
  include Mongoid::Document
  field :email, type: String
  field :salt, type: String
  field :hashed_password, type: String

  before_save :hash_password

  def authenticated?(pwd)
  	self.hashed_password == BCrypt::Engine.hash_secret(pwd, salt)
  end

  private

  def hash_password
  	self.salt = BCrypt::Engine.generate_salt
  	self.hashed_password = BCrypt::Engine.hash_secret(password, salt)
  	self.password = nil
  end

end
