class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.belongs_to :review, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
