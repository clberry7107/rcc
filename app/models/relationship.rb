class Relationship < ActiveRecord::Base
  
  validates_presence_of :book_index, :name_index
  
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
    return create_relationships(file)
  end
    
  def self.create_relationships(file)
    relations = Array.new
    
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1') do |row|
      relations << add_relationship(row)
    end  
    
    return relations
  end
  
  def self.add_relationship(row)
    
    relationship = Relationship.new
    relationship.book_index = row['Book Index']
    relationship.name_index = row['Name Index'] 
    relationship.quantity = row['Quantity']
    relationship.date_added = row['Date Input']
    return relationship.transfer_relationship(relationship.name_index, relationship.book_index, relationship.quantity)
  end rescue nil
  
  def transfer_relationship(name, book, quantity)
    db_book = (Book.find_by(index: book))
    book_id = db_book.id unless db_book.nil?
    db_subscriber = (Subscriber.find_by index: name)
    subscriber_id = db_subscriber.id unless db_subscriber.nil?
    
    relation = SubscribersBook.new
    relation.subscriber_id = subscriber_id 
    relation.book_id = book_id
    relation.quantity = quantity
    
    return relation
  end
  
  def book_id
    if !(Book.find_by index: self.book_index).nil?
      (Book.find_by index: self.book_index).id
    else
      Book.first.id
    end
  end
  
  def subscriber_id
    if !(Subscriber.find_by index: self.name_index).nil?
      (Subscriber.find_by index: self.name_index).id
    end
  end
  
end
