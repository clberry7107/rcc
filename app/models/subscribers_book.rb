class SubscribersBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :subscriber
  
  validates_presence_of :book_id, :subscriber_id
  
  
  def date_created
    self.created_at.strftime('%m/%d/%Y')  
  end
end