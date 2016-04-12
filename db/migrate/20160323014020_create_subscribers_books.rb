class CreateSubscribersBooks < ActiveRecord::Migration
  def change
    create_table :subscribers_books do |t|
      t.integer :subscriber_id
      t.integer :book_id
      
    end
  end
end
