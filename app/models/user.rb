class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  before_validation(on: :update) do
    self.home_phone = home_phone.gsub(/[^0-9]/, "")
    self.work_phone = work_phone.gsub(/[^0-9]/, "")
    self.mobile_phone = mobile_phone.gsub(/[^0-9]/, "")
    self.zip = zip.gsub(/[^0-9]/,"")
  end
         
  def full_name
    "#{self.f_name} #{self.l_name}"
  end
  
  def address
    "#{self.address1} #{self.address2}"
  end
  
  def next_user
    self.id == User.last.id ? (User.first.id) : (User.where("id > ?", self.id).first)
  end
  
  def previous_user
    self.id == User.first.id ? (User.last.id) : (User.where("id < ?", self.id).last)
  end
  
  def f_home_phone
    self.home_phone.nil? ? (return nil) : f_number(self.home_phone.chars())
  end
  
  def f_work_phone
    self.work_phone.nil? ? (return nil) : f_number(self.work_phone.chars())
  end
  
  def f_mobile_phone
    self.mobile_phone.nil? ? (return nil) : f_number(self.mobile_phone.chars())
  end
    
  def f_number(num_array)
    return nil unless num_array.length > 0
    return "(#{num_array[0..2].join}) #{num_array[3..5].join}-#{num_array[6..9].join}"
  end
  
  def f_zip
    self.zip == nil ? (return nil) : self.zip.length > 5 ? self.zip.insert(5, '-') : self.zip
  end

end
