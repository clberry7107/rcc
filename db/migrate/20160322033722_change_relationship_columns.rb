class ChangeRelationshipColumns < ActiveRecord::Migration
  def change
    remove_column :relationships, :creative_index
    
    add_column :relationships, :quantity, :integer
    add_column :relationships, :date_added, :date
  end
end
