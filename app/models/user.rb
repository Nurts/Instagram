class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    has_many :posts

    validates_presence_of :email, :username
    validates_uniqueness_of :email, :username
    validates :password, length: {minimum: 6, maximum: 30} 
    validates_email_format_of :email, message: 'The email format is not correct!'
    validates :username, :password, format: { with: /\A[0-9a-zA-Z_.\-]+\Z/, message: "Only alphanumeric characters, and -_."}
    validates :username, length: {maximum: 30}

    before_create {self.email = email.downcase}
    before_create {self.username = username.downcase}
end
