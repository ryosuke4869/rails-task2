class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: {message: '(開始日)を入力してください'}
  validates :end_date, presence: {message: '(終了日)を入力してください'}
  validates :persons, presence: {message: '(人数)を入力してください'}

  validate :start_end_check
    def start_end_check
      if self.start_date = nil
        errors.add(:start_date,"(開始日）を入力してください")
      elsif self.end_date = nil
        errors.add(:end_date,"(終了日）を入力してください")
      elsif self.end_date.to_i < self.start_date.to_i
        errors.add(:end_date,"(終了日）は開始日以降の日付にしてください")
      end
    end

    def total
      binding.pry
      room.price * persons * (end_date - start_date).to_i
    end

    def days
      binding.pry
      (end_date - start_date).to_i + 1
    end

    def stay
      binding.pry
      (end_date - start_date).to_i
    end

end
