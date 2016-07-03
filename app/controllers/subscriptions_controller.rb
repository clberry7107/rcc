class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscriber
  def index
    
  end
  
  def new
    @books = Book.all.where("active = ?", :true).order('title ASC')
    session[:request_page] = request.env["HTTP_REFERER"] || subscriber_path(@subscriber)
    render 'subscribers/add_subscription'
  end
  
  def combine
    @subscribers = Subscriber.all.order('last_name')
    render 'subscribers/merge_subscriptions'
  end
  
  def create
    books = Array.new
    if !params[:q].nil?
      params[:q].each do |k, v|
        books << {book: k, quantity: v} unless v == "" || v == 0
      end
    end
    
    books.each do |book|
      SubscribersBook.create(subscriber_id: @subscriber.id, book_id: book[:book], quantity: book[:quantity])
    end

    redirect_to session[:request_page]
  end
  
  def update
    sbs = SubscribersBook.where('subscriber_id = ?', @subscriber.id)
    params[:q].each do |k,v|
      sb = sbs.find_by(book_id: k)
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
      @selected = Subscriber.find(params[:selected])
      
      @subscriber.subscribers_books.each do |subscription|
        if @selected.subscribers_books.find_by(book_id: subscription.book_id).nil?
          sb = SubscribersBook.new
          sb.subscriber_id = @selected.id
          sb.book_id = subscription.book_id
          sb.quantity = subscription.quantity
          sb.save
        end
      end
      
      @selected.subscribers_books.each do |subscription|
        if @subscriber.subscribers_books.find_by(book_id: subscription.book_id).nil?
          sb = SubscribersBook.new
          sb.subscriber_id = @subscriber.id
          sb.book_id = subscription.book_id
          sb.quantity = subscription.quantity
          sb.save
        end
      end
      
      redirect_to subscriber_path(@subscriber)
    else
      redirect_to subscriber_path(@subscriber), notice: "No subscriber was selected. No merge occured."
    end
  end
  
  def destroy
    
  end
  
  private
    def set_subscriber
      if params[:subscriber]
        @subscriber =Subscriber.find(params[:subscriber])
      else
        @subscriber = Subscriber.find(params[:subscriber_id])
      end
    end
    
    
end