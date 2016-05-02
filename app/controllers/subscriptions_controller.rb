class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscriber
  def index
    
  end
  
  def new
    @subscriber = Subscriber.find(params[:subscriber])
    @books = Book.all.where("active = ?", true).order('title ASC')
    render 'subscribers/add_subscription'
  end
  
  def create
    books = Array.new
    params[:q].each do |k, v|
      books << {book: k, quantity: v} unless v == "" || v == 0
    end
    
    relationships = Array.new
    books.each do |book|
        relationships << {
                        "name_index" => Subscriber.find(params[:subscriber_id]).index, 
                        "book_index" => Book.find(book[:book]).index, 
                        "quantity" => book[:quantity],
                        "date_added" => Date.today
                        }
      
    end
    
    relationships.each do |relationship|
      r = Relationship.create(relationship)
      
      relation = SubscribersBook.new
      relation.subscriber_id = params[:subscriber_id] 
      relation.book_id = (Book.find_by(index: r.book_index)).id
      relation.save
      
    end
    
    redirect_to subscriber_path(@subscriber)
  end
  
  def update
    params[:q].each do |k,v|
      relation = Relationship.where("book_index = ? AND name_index = ?", Book.find(k).index, @subscriber.index).limit(1)
      if v == '0'
        sb = @subscriber.subscribers_books.where("book_id = ?", k).limit(1)
        SubscribersBook.destroy(sb) unless sb.empty?
        Relationship.destroy(relation.first.id) unless relation.empty?
      else
        Relationship.update(relation.first.id, :quantity => v)
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