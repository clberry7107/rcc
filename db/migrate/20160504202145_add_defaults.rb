class AddDefaults < ActiveRecord::Migration
  def change
    change_column_default :subscribers, :active, :true
    change_column_default :books, :stock_quantity, 0
  end
end
