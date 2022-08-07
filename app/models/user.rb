class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :rooms
  has_many :reservations

  has_one_attached :user_image

  validates :user_name, presence: {message: 'を入力してください'}
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
