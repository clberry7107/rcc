class BookSubscribersController < ApplicationController
  before_action :set_book
  
  def index
    
  end
  
  def new
    @subscribers = Subscriber.all.where("active = ?", :true).order('last_name ASC').reject{ |subscriber| @book.subscribers.include?(subscriber)}
    session[:request_page] = request.env['HTTP_REFERER'] || relationships_path
    render 'books/add_subscribers'
  end
  
  def edit
    session[:request_page] = request.env['HTTP_REFERER'] || book_path(@book)
    render 'books/edit_subscribers'
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