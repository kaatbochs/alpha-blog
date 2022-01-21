class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { maximum: 105 },
                       format: { with: VALID_EMAIL_REGEX }
  PASSWORD_COMPLEXITY = /\A
    (?=.{8,})           # at least 8 characters
    (?=.*\d)            # at least 1 digit
    (?=.*[a-z])         # at least 1 lower case
    (?=.*[A-Z])         # at least 1 upper case
    (?=.*[[:^alnum:]])  # at least 1 symbol
  /x
  validates :password, format: PASSWORD_COMPLEXITY  
  has_secure_password
end
