class FulfillmentController < ApplicationController
  before_action :authenticate_user!
   
  def index

    @subscribers = Array.new
    Subscriber.where("active = ?", true).order(:last_name).includes(:books).where('active = ?', true).order('books.title').all.each do |subscriber|
      @subscribers << subscriber unless subscriber.total_books == 0
    end
      
    @books = Array.new
    Book.where('active = ?', true).order(:title).includes(:subscribers).where("active = ?", true).order('subscribers.last_name').all.each do |book|
      @books << book unless book.subscribers.count == 0
    end
    
    @average = @books.length / @subscribers.length rescue 0
  end
end