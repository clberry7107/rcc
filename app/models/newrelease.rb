class Newrelease < ActiveRecord::Base
  #attr_accessible :item_code, :discount_code, :title, :price, :vendor
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      issue = Newrelease.new
      issue.item_code = row['ITEMCODE']
      issue.discount_code = row['DiscountCode']
      issue.title = row['TITLE']
      issue.price = row['PRICE']
      issue.vendor = row['Vendor']
      issue.save
    end
  end

end
