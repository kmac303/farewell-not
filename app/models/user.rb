class User < ApplicationRecord
    has_secure_password
    has_many :messages
    has_one :match
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
end
