class FulfillmentController < ApplicationController
   
  def index
    @subscribers = Array.new
    Subscriber.order(:last_name).all.each do |subscriber|
      @subscribers << subscriber unless subscriber.total_books == 0
    end
    
    @books = Array.new
    Book.order(:title).all.each do |book|
      @books << book unless book.subscribers.count == 0
    end
  end
   
end