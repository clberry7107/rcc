class BookSubscribersController < ApplicationController
  before_action :set_book
  
  def index
    
  end
  
  def new
    @subscribers = Subscriber.all.where(active: [true, :true]).order('last_name ASC').reject{ |subscriber| @book.subscribers.include?(subscriber)}
    session[:request_page] = request.env['HTTP_REFERER'] || relationships_path
    render 'books/add_subscribers'
  end
  
  def edit
    session[:request_page] = request.env['HTTP_REFERER'] || book_path(@book)
    render 'books/edit_subscribers'
  end
  
  def combine
    @books = Book.all.order('title')
    render 'books/merge_subscriptions'
  end
  
  def create
    if !params[:q].nil?
      params[:q].each do |subscriber, quantity|
        @book.subscribers_books.create(subscriber_id: subscriber, quantity: quantity) unless quantity.empty? || quantity == "0"
      end
    end
    redirect_to session[:request_page]
  end
  
  def update
    sbs = SubscribersBook.where('book_id = ?', @book.id)
    params[:q].each do |k,v|
      sb = sbs.find_by(subscriber_id: k)
      next if sb.nil?
      
      case v 
       when "0"
        sb.delete
      else
        sb.update(quantity: v)
      end
    end
    
    redirect_to session[:request_page]
  end
  
  def merge
    if params[:selected]
      @selected = Book.find(params[:selected])
    
      @book.subscribers_books.each do |subscription|
        if @selected.subscribers_books.find_by(subscriber_id: subscription.subscriber_id).nil?
          sb = SubscribersBook.new
          sb.subscriber_id = subscription.subscriber.id
          sb.book_id = @selected.id
          sb.quantity = subscription.quantity
          sb.save
        end
      end
      
      @selected.subscribers_books.each do |subscription|
        if @book.subscribers_books.find_by(subscriber_id: subscription.subscriber_id).nil?
          sb = SubscribersBook.new
          sb.subscriber_id = subscription.subscriber_id
          sb.book_id =  @book.id
          sb.quantity = subscription.quantity
          sb.save
        end
      end
      
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book), notice: "No book was selected.  No merge occured."
    end
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