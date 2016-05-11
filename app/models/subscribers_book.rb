class SubscribersBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :subscriber
  
  def date_created
    self.created_at.strftime('%m/%d/%Y')  
  end
end