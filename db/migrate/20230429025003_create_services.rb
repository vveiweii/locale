class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :business, null: false, foreign_key: true
      t.string :name
      t.float :price
      t.text :description
      t.text :offer
      t.text :available

      t.timestamps
    end
  end
end
