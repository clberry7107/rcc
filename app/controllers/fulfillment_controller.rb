class FulfillmentController < ApplicationController
  before_action :authenticate_user!
   
  def index

    @subscribers = Array.new
    Subscriber.order(:last_name).all.each do |subscriber|
      @subscribers << subscriber unless !subscriber.active || subscriber.active_subscriptions == 0 
    end
    
    # @subscribers = Subscriber.all.order(:last_name).where(:active => :true)
    
    @books = Array.new
    Book.order(:title).all.each do |book|
      @books << book unless !book.active || book.subscribers.count == 0
    end
    
    # @books = Book.all.order(:title).where(:active => :true)
    
    @total_copies = 0
    @books.each {|book| @total_copies += book.order_quantity}
    @average = (@books.count.to_f / @subscribers.count.to_f).round(2) rescue 0
    
    # @books = @books.paginate(:page => params[:page], :per_page => 10)
    # @subscribers = @subscribers.paginate(:page => params[:page], :per_page => 10)
  end
end