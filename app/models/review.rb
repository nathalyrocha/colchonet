class Review < ApplicationRecord
  POINTS = (1..5).to_a

  validates_uniqueness_of :user_id, scope: :room_id
  validates_presence_of :points, :user_id, :room_id
  validates_inclusion_of :points, in: POINTS

  belongs_to :user
  belongs_to :room, counter_cache: true

  def self.stars
    (average(:points) || 0).round
  end
end
