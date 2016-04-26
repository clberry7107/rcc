class AddQuantityToSubscribersbook < ActiveRecord::Migration
  def change
    add_column :subscribers_books, :quantity, :integer
    add_column :subscribers, :active, :boolean
  end
end
