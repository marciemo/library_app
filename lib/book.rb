class Book
  include Validate
  
  attr_reader :title, :author_id, :category_id

  def initialize(title, author_id = nil, category_id = nil)
    @title = title
    @author_id = author_id
    @category_id = category_id
  end

  def self.all
    Book.from_pg_result(DB.exec("SELECT * FROM book;"))
  end

  def save
    DB.exec("INSERT INTO book (title, author_id, category_id) VALUES ('#{@title}', '#{author_id}', '#{category_id}')")
  end

  def self.search(title)
    choice = title
    id_array = from_pg_result(DB.exec("SELECT book.author_id, book.category_id FROM book WHERE book.title = '#{choice}'"))
    author_id = id_array.first.author_id
    category_id = id_array.first.category_id
    result = from_pg_result_search(DB.exec("SELECT book.title, author.first_name, author.last_name, genre.category FROM book, author, genre 
    WHERE book.title = '#{choice}' and author.author_id = '#{author_id}' and genre.category_id = '#{category_id}'"))
  end


  private

  def self.from_pg_result(pg_result)
    pg_result.inject([]) { |books, book_hash| books << Book.new(book_hash["title"], book_hash["author_id"], book_hash["category_id"])}
  end


  def self.from_pg_result_search(pg_result)
    pg_result.inject([]) { |books, book_hash| [book_hash["title"], book_hash["first_name"], book_hash["last_name"], book_hash["category"]] }
  end

end
