class AddDefaultBookActive < ActiveRecord::Migration
  def change
    change_column_default :books, :active, :true
  end
end
