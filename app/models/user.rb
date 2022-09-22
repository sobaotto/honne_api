class User < ApplicationRecord
    has_secure_password

    has_many :questions
    has_many :answers
end
