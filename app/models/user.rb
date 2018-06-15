class User < ApplicationRecord
    has_secure_password
    validates_presence_of :email, :username
    validates_uniqueness_of :email, :username
    validates :password, length: {minmum: 6, maximum: 50} 
end
