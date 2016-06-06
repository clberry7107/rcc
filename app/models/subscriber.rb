class Subscriber < ActiveRecord::Base
  has_many :subscribers_books
  has_many :books, through: :subscribers_books
  
  attr_accessor :importing
  
  before_validation(on: :update) do
    check_formating
  end
  
  before_validation(on: :create) do
    check_formating 
    valid_name?
  end
  
  def check_formating
    self.home_phone = home_phone.gsub(/[^0-9]/, "") unless self.home_phone.nil?
    self.work_phone = work_phone.gsub(/[^0-9]/, "") unless self.work_phone.nil?
    self.mobile_phone = mobile_phone.gsub(/[^0-9]/, "") unless self.mobile_phone.nil?
    self.zip = zip.gsub(/[^0-9]/,"") unless self.zip.nil?
    self.first_name.capitalize!
    self.last_name.capitalize!
  end
  
  validates :first_name, :last_name, presence: true 
  validate :any_present? 
  validates :email, uniqueness: true

  def any_present?
    if %w(home_phone work_phone mobile_phone email).all?{|attr| self[attr].blank?}
      errors.add :base, "There is no way to contact this user.  Please add email or phone number."
    end
  end
  
  def valid_name?
    if Subscriber.where(["first_name = ? and last_name = ?", self.first_name, self.last_name]).count > 0
      errors.add :base, "Subscriber name already taken. Please ensure you are not creating a duplicate subscriber."
    end
  end
  
  def self.remove_newline(value)
    if !value.chr.is_number? 
      value = value.gsub!("\n", ", ") unless value.include?("\"")
    end rescue value
  end
    
  def self.is_number?(string)
    true if Float(string) rescue false
  end
    
    
  def self.import(file)
    f = file.read
    lines = f.each_line('\n')
    lines.each {|line| remove_newline(line)}
    @subscribers = create_subsribers(file)
    return @subscribers
  end
    
  def self.create_subsribers(file)
    @subscribers = Array.new
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1') do |row|
      if row['Type'] == 'C'
        @subscribers << add_subscriber(row)
      end 
    end 
    return @subscribers
  end
  
  def self.add_subscriber(row)
    subscriber = Subscriber.new
    subscriber.index = row['Name Index'].to_i
    subscriber.last_name = row['Last Name'] 
    subscriber.first_name = row['First Name']
    subscriber.address = row['Address']
    subscriber.city = row['City']
    subscriber.state = row['State']
    subscriber.zip = row['Zip']
    subscriber.home_phone = row['Home Phone']
    subscriber.work_phone = row['Work Phone']
    subscriber.start_date = row['Start Date']
    subscriber.mail_list = row['Mail List']
    subscriber.last_edit = row['Last Edit']
    subscriber.subscriber_type = row['Type']
    subscriber.notes = remove_newline(row['Notes']) unless row['Notes'].nil?
    subscriber.importing = true
    return subscriber
  end 
  
  def full_name
    return "#{self.first_name} #{self.last_name}"
  end
  
  def next_subscriber
    subs = Subscriber.order(:last_name).to_a
    sub = subs.index(self) + 1
    sub > subs.length - 1 ? subs.first.id : subs[sub].id
  end
  
  def previous_subscriber
    subs = Subscriber.order(:last_name).to_a
    sub = subs.index(self) - 1
    sub > subs.length - 1 ? subs.first.id : subs[sub].id
  end
  
  def f_home_phone
    self.home_phone == nil ? (return nil) : f_number(self.home_phone.chars())
  end
  
  def f_work_phone
    self.work_phone == nil ? (return nil) : f_number(self.work_phone.chars())
  end
  
  def f_mobile_phone
    self.mobile_phone == nil ? (return nil) : f_number(self.mobile_phone.chars())
  end
    
  def f_number(num_array)
    return nil unless num_array.length > 0
    return "(#{num_array[0..2].join}) #{num_array[3..5].join}-#{num_array[6..9].join}"
  end
  
  def f_zip
    self.zip == nil ? (return nil) : self.zip.length > 5 ? self.zip.insert(5, '-') : self.zip
  end
  
  def book_quantity(book)
    self.subscribers_books.find_by(book_id: book).quantity
  end
  
  def active_subscriptions
    count = 0
    self.books.each do |book|
      book.active ? count += 1 : count = count
    end
    return count
  end
  
  def total_books
    total = 0
    self.subscribers_books.each do |book|
      if Book.find(book.book_id).active?
        total += book.quantity
      end
    end
    return total
  end
  
  
  
end
