class ChangeOfferColumnInServices < ActiveRecord::Migration[7.0]
  def change
    change_column :services, :offer, :decimal, precision: 8, scale: 2, using: 'offer::numeric(8,2)'
  end
end
