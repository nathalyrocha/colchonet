class User < ApplicationRecord
  validates :email, :full_name, :location, presence: true
  validates :bio, length: { minimum: 30 }, allow_blank: false
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }, uniqueness: true

  has_secure_password
end
