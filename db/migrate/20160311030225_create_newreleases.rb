class CreateNewreleases < ActiveRecord::Migration
  def change
    create_table :newreleases do |t|
      t.string :item_code
      t.string :discount_code
      t.string :title
      t.decimal :price
      t.string :vendor

      t.timestamps null: false
    end
  end
end
