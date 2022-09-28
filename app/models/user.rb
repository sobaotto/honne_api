class User < ApplicationRecord
    has_secure_password

    has_many :questions
    has_many :answers

    validates :name, presence: true, uniqueness: true, length: { minimum:2, maximum:30 }, format: { with: /\A[A-Za-z0-9_-]+\z/ }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
