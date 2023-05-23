class AddIndustryToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :industry, :string
  end
end
