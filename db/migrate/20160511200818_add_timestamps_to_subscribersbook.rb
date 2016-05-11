class AddTimestampsToSubscribersbook < ActiveRecord::Migration
  def change
    add_timestamps(:subscribers_books)
  end
end
