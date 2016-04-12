class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :index
      t.string :last_name
      t.string :first_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :home_phone
      t.string :work_phone
      t.string :start_date
      t.string :mail_list
      t.string :last_edit
      t.string :type
      t.text :notes
      
      t.timestamps null: true
    end
  end
end
