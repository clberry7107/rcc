class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :book_index 
      t.integer :name_index
      t.integer :creative_index
      
      t.timestamps null: false
    end
  end
end
