class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true #Userを示す外部キーuser_idを紐付け
      t.references :room, foreign_key: true#Roomを示す外部キーroom_idを紐付け
      t.date :start_date
      t.date :end_date
      t.integer :persons
      t.string :room_name
      t.integer :user_name

      t.timestamps
    end
  end
end

