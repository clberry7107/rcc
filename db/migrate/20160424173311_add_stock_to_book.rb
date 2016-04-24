class AddStockToBook < ActiveRecord::Migration
  def change
    add_column :books, :stock_quantity, :integer, :defualt =>  0
  end
end
