class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :table_map, :remove_newline, :title
    
  def table_map
     {:item_code => "ITEMCODE", 
     :discount_code => "DiscountCode", 
     :title => "TITLE", 
     :price => "PRICE", 
     :vendor => "Vendor"}
  end
    
  rescue_from "AccessGranted::AccessDenied" do |exception|
    redirect_to root_path, notice: "You don't have permission to access this page."
  end
    
end
