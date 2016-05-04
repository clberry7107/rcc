class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:guest, :user, :admin]

         
  before_validation(on: :update) do
    self.home_phone = home_phone.gsub(/[^0-9]/, "") unless self.home_phone.nil?
    self.work_phone = work_phone.gsub(/[^0-9]/, "") unless self.work_phone.nil?
    self.mobile_phone = mobile_phone.gsub(/[^0-9]/, "") unless self.mobile_phone.nil?
    self.zip = zip.gsub(/[^0-9]/,"") unless self.zip.nil?
  end
         
  def full_name
    "#{self.f_name} #{self.l_name}"
  end
  
  def address
    "#{self.address1} #{self.address2}"
  end
  
  def next_user
    users = User.order(:l_name).to_a
    user = users.index(self) + 1
    user > users.length - 1 ? users.first.id : users[user].id
  end
  
  def previous_user
    users = User.order(:l_name).to_a
    user = users.index(self) - 1
    user > users.length - 1 ? users.first.id : users[user].id
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
  
  def is_admin
    self.user_type == "admin"
  end
  
  def clerk?
    self.user_type == "clerk"
  end
  
  def can_view?
    self.clerk? || self.is_admin
  end

end
