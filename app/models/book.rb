class Book < ActiveRecord::Base
  has_many :subscribers_books
  has_many :subscribers, through: :subscribers_books
  
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
    create_book(file)
  end
    
  def self.create_book(file)
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1') do |row|
      add_book(row)
    end  
  end
  
  def self.add_book(row)
    book = Book.new
    book.index = row['Book Index']
    book.title = row['Book'] 
    book.active = row['Active']
    book.notes = remove_newline(row['Notes']) unless row['Notes'].nil?
    book.save
  end rescue nil
  
  def order_quantity
    Relationship.where("book_index = ?", self.index).sum(:quantity)
  end
  
  def next_book
    self.id == Book.last.id ? (self.id) : (Book.where("id > ?", self.id).first)
  end
  
  def previous_book
    self.id == Book.first.id ? (self.id) : (Book.where("id < ?", self.id).last)
  end
end
