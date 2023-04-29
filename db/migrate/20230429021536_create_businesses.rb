class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.integer :postcode
      t.string :available
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
