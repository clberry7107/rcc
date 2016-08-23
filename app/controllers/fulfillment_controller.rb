class FulfillmentController < ApplicationController
  before_action :authenticate_user!
   
  def index
    case params[:format]
      when "subscriber"
        @subscribers = Array.new
        Subscriber.order(:last_name).all.each do |subscriber|
          @subscribers << subscriber unless !subscriber.active || subscriber.active_subscriptions == 0 
        end
        @format = "subscriber"
      when "book"
        @books = Array.new
        Book.order(:title).all.each do |book|
          @books << book unless !book.active || book.subscribers.count == 0
        end
        @format = "book"
      else
        @format = "none"
    end
  end
end