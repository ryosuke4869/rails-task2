class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_one_attached :room_image

  scope :recent, -> { order(created_at: :desc) }
  validates :room_name, :introduction, :price, :address, presence: {message: 'を入力してください'}
end
