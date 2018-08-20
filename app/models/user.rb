class User < ApplicationRecord

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
    presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 254 }
  validates :admin,
    inclusion: { in: [true, false] }
  # パスワードは半角英小文字大文字数字が1種類以上含まれて8文字以上であること
  validates :password,
    presence: true, length: { minimum: 8 }, format: {allow_blank: true, with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/}

end
