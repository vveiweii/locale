class ChangeOfferColumnInServices < ActiveRecord::Migration[7.0]
  def change
    change_column :services, :offer, :float, using: 'offer::float'
  end
end
