class User < ApplicationRecord
  validates :email, :full_name, :location, presence: true
  validates :bio, length: { minimum: 30 }, allow_blank: false
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }, uniqueness: true

  has_secure_password
  before_create :generate_token

  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?

    self.confirmed_at = Time.current
    self.confirmation_token = ''

    save!
  end

  def confirmed?
    confirmed_at.present?
  end
end
