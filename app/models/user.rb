class User < ApplicationRecord
  validates :email, :full_name, :location, presence: true
  validates :bio, length: { minimum: 30 }, allow_blank: false
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }, uniqueness: true

  scope :confirmed, -> { where('confirmed_at IS NOT NULL') }

  has_secure_password
  before_create :generate_token

  has_many :rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def self.authenticate(email, password)
    confirmed.find_by_email(email).try(:authenticate, password)
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
