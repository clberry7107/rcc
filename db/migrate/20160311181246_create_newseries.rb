class CreateNewseries < ActiveRecord::Migration
  def change
    create_table :newseries do |t|
      t.string :vendor_name
      t.string :item_number
      t.string :discount_code
      t.string :preview_page_no
      t.string :description
      t.string :price
      t.string :srp

      t.timestamps null: true
    end
  end
end
