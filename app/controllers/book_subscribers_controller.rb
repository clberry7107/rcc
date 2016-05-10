class BookSubscribersController < ApplicationController
  before_action :set_book
  
  def index
    
  end
  
  def add
    
  end
  
  def edit
    
  end
  
  def create
    
  end
  
  def update
    
  end

  def destroy
    
  end
    
    
  private
    
  def set_book
    @book = Book.find(params[:id])
    @subscribers = @book.subscribers
  end 
    
  def book_params
    params.require(:book).permit(:subscribers)
  end
end