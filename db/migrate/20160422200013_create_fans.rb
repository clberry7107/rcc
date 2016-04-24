class CreateFans < ActiveRecord::Migration
  def change
    create_table :fans do |t|
      t.string :f_name
      t.string :l_name
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
