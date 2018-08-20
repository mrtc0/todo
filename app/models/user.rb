require 'bcrypt'

class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
    presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 254 }
  validates :admin,
    inclusion: { in: [true, false] }
  validates :password,
    presence: true

  def password=(plain_password)
    self[:password] = BCrypt::Password.create(plain_password)
  end

  def authenticate
    @user = User.find_by(email: params[:email])
    @user.password == params[:password]
  end
end
