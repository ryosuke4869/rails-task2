class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: {message: '(開始日)を入力してください'}
  validates :end_date, presence: {message: '(終了日)を入力してください'}
  validates :persons, presence: {message: '(人数)を入力してください'}

  validate :start_end_check
    def start_end_check
      if start_date == nil
        errors.add(:start_date,"(開始日）を入力してください")
      elsif end_date == nil
        errors.add(:end_date,"(終了日）を入力してください")
      elsif end_date < start_date
        errors.add(:end_date,"(終了日）は開始日以降の日付にしてください")
      end
    end

    def total
      room.price * persons * (end_date - start_date).to_i
    end

    def days
      (end_date - start_date).to_i + 1
    end

    def stay
      (end_date - start_date).to_i
    end

end
