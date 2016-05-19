class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscriber
  def index
    
  end
  
  def new
    @books = Book.all.where("active = ?", :true).order('title ASC')
    render 'subscribers/add_subscription'
  end
  
  def create
    books = Array.new
    params[:q].each do |k, v|
      books << {book: k, quantity: v} unless v == "" || v == 0
    end
    
    books.each do |book|
      SubscribersBook.create(subscriber_id: @subscriber.id, book_id: book[:book], quantity: book[:quantity])
    end
    
    # relationships = Array.new
    # books.each do |book|
    #     relationships << {
    #                     "name_index" => Subscriber.find(params[:subscriber_id]).index, 
    #                     "book_index" => Book.find(book[:book]).index, 
    #                     "quantity" => book[:quantity],
    #                     "date_added" => Date.today
    #                     }
      
    # end
    
    # relationships.each do |relationship|
    #   r = Relationship.create(relationship)
      
    #   relation = SubscribersBook.new
    #   relation.subscriber_id = params[:subscriber_id] 
    #   relation.book_id = (Book.find_by(index: r.book_index)).id
    #   relation.save
      
    # end
    
    redirect_to subscriber_path(@subscriber)
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
    
    redirect_to subscriber_path(@subscriber)
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