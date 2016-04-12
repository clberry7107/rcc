class SubscriptionsController < ApplicationController
  
  def index
    
  end
  
  def new
    @subscriber = Subscriber.find(params[:subscriber])
    @books = Book.all.order('title ASC')
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
    
    redirect_to subscriber_path(params[:subscriber_id])
  end
  
  def update
    params[:q].each do |k,v|
      relation = Relationship.where("book_index = ? AND name_index = ?", Book.find(k).index, Subscriber.find(params[:subscriber_id]).index).limit(1)
      Relationship.update(relation.first.id, :quantity => v)
    end
    
    redirect_to subscriber_path(params[:subscriber_id])
  end
  
  def destroy
    
  end
  
  private
  
    
end