class DropShoppingCartTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :shopping_cart_items
    drop_table :shopping_carts
  end
end
