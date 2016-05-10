class BookSubscribersController < ApplicationController
  before_action :set_book
  
  def index
    
  end
  
  def new
    @subscribers = Subscriber.all.where("active = ?", :true).order('last_name ASC').reject{ |subscriber| @book.subscribers.include?(subscriber)}
    render 'books/add_subscribers'
  end
  
  def edit
    render 'books/edit_subscribers'
  end
  
  def create
    params[:q].each do |subscriber, quantity|
      @book.subscribers_books.create(subscriber_id: subscriber, quantity: quantity) unless quantity.empty? || quantity == "0"
    end
    redirect_to books_path
  end
  
  def update
    params[:q].each do |subscriber, quantity|
      relationships = @book.subscribers_books.where(subscriber_id: subscriber)
      relationships.each do |r|
        r.delete unless !r.quantity.nil?
      end
      relationship = @book.subscribers_books.where(subscriber_id: subscriber).first
      relationship.update(quantity: quantity) unless relationship.nil?
    end
    redirect_to books_path
  end

  def destroy
    
  end
    
    
  private
    
  def set_book
    @book = Book.find(params[:id])
    @subscribers = @book.subscribers
  end 
    
  def book_params
    params.require(:book).permit(:id, :q)
  end
end