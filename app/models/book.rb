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
    book.notes = remove_newline(row['Notes']) unless row['Notes'].nil?
    book.active = false unless row['Active'].to_i == 1
    book.save
  end rescue nil
  
  def order_quantity
    self.stock_quantity = 0 unless !self.stock_quantity.nil?
    Relationship.where("book_index = ?", self.index).sum(:quantity) + self.stock_quantity
    # total = 0
    # self.subscribers.each do |subscriber|
    #   total =+ subscriber.book_quantity(self) unless !subscriber.active
    # end
  end
  
  def next_book
    alpha_books = Book.order(:title).to_a
    book = alpha_books.index(self) + 1
    book > alpha_books.length - 1 ? alpha_books.first.id : alpha_books[book].id
  end
  
  def previous_book
    alpha_books = Book.order(:title).to_a
    book = alpha_books.index(self) - 1
    book < 0 ? alpha_books.last.id : alpha_books[book].id
  end
end
