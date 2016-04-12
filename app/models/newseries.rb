class Newseries < ActiveRecord::Base
    
  def self.import(file)
    CSV.foreach(file.path, { :col_sep => "\t", :headers => true }) do |row|
      series = Newseries.new
      series.vendor_name = row['VENDOR_NAME']
      series.item_number = row['ITEM_NO']
      series.discount_code = row['DISCOUNT_CODE']
      series.preview_page_no = row['PREVIEWS_PAGE_NO']
      series.description = row['DESCRIPTION']
      series.price = row['PRICE']
      series.srp = row['SRP']
      series.save
    end
  end
  
  def f_price
    return to_usd(self.price)
  end
  
  def f_srp
    return to_usd(self.srp)
  end
  
  def to_usd(cost)
    return "$#{cost}"
  end
end
