class Fan < ActiveRecord::Base
    
  validates :email, uniqueness: true
  validates :f_name, :l_name, :email, presence: true
  
end
  