class FulfillmentController < ApplicationController
  before_action :authenticate_user!
   
  def index
    if params[:q]
      params[:format] = params[:q][:format_eq]
    end
    case params[:format]
      when "subscriber"
        @subscribers = Subscriber.includes(:subscribers_books).where(active: [true,:true], subscribers_books: { quantity: 1}).order(:last_name)
        @search = @subscribers.search(params[:q])
        @subscribers = @search.result
        @format = "subscriber"
      when "book"
        @books = Book.includes(:subscribers_books).where(active: [true,:true], subscribers_books: { quantity: 1}).order(:title)
        @search = @books.search(params[:q])
        @books = @search.result
        if params[:first_letter]
          if params[:first_letter] == "0-9"
            @books = @books.where("title LIKE ?", "#{[0..9]}%")
          elsif params[:first_letter] == "a-z"
            @books = @books
          else
            @books = @books.where("title LIKE ?", "#{params[:first_letter]}%")
          end
        end
        # @books = @books.paginate(:page => params[:page], :per_page => 5)
        @format = "book"
      else
        @format = "none"
    end
  end
end