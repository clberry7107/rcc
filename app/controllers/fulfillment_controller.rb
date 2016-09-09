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
        # @subscribers = @subscribers.paginate(:page => params[:page], :per_page => 5)
        @format = "subscriber"
      when "book"
        @books = Book.includes(:subscribers_books).where(active: [true,:true], subscribers_books: { quantity: 1}).order(:title)
        @search = @books.search(params[:q])
        @books = @search.result
        # @books = @books.paginate(:page => params[:page], :per_page => 5)
        @format = "book"
      else
        @format = "none"
    end
  end
end