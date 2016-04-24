class Fan < ActiveRecord::Base
  
  before_validation do
    self.f_name.capitalize!
    self.l_name.capitalize!
  end
  
  validates :email, uniqueness: true
  validates :f_name, :l_name, :email, presence: true
  
  def full_name
    return "#{self.f_name} #{self.l_name}"
  end
  
end
  