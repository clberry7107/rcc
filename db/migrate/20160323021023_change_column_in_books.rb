class ChangeColumnInBooks < ActiveRecord::Migration
  def change
    rename_column :books, :book_index, :index
  end
end
