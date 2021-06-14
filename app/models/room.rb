class Room < ActiveRecord::Base
  extend FriendlyId

  validates_presence_of :title
  validates_presence_of :slug

  friendly_id :title, use: [:slugged, :history]

  has_many :reviews, dependent: :destroy
  has_many :reviewed_rooms, through: :reviews, source: :room, dependent: :destroy


  mount_uploader :picture, PictureUploader
  friendly_id :title, use: [:slugged, :history]

  belongs_to :user

  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query.present?
      where(['location ILIKE :query OR title ILIKE :query OR description ILIKE :query', query: "%#{query}%"])
    else
      all
    end
  end
end
