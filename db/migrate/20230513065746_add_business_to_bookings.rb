class AddBusinessToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :business, null: true, foreign_key: true
  end
end
