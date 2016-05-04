class FulfillmentController < ApplicationController
  before_action :authenticate_user!
   
  def index

    @subscribers = Array.new
    Subscriber.order(:last_name).all.each do |subscriber|
      @subscribers << subscriber unless !subscriber.active || subscriber.total_books == 0 
    end
  
    @books = Array.new
    Book.order(:title).all.each do |book|
      @books << book unless !book.active || book.subscribers.count == 0
    end
    
    @total_copies = 0
    @books.each {|book| @total_copies += book.order_quantity}
    @average = (@books.count.to_f / @subscribers.count.to_f).round(2) rescue 0
  end
end