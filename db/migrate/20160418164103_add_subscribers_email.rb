class AddSubscribersEmail < ActiveRecord::Migration
  def change
    add_column :subscribers, :email, :string, :default => ""
  end
end
