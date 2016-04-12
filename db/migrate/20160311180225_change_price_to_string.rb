class ChangePriceToString < ActiveRecord::Migration
  def change
    change_column :newreleases, :price, :string
  end
end
