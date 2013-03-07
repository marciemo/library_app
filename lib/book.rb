class Book
  attr_reader :title, :author_id, :category_id

  def initialize(title, author_id, category_id)
    @title = title
    @author_id = author_id
    @category_id = category_id
  end

  def self.all
    Book.from_pg_result(DB.exec("SELECT * FROM book;"))
  end

  def save
    DB.exec("INSERT INTO book (title) VALUES ('#{@title}')")
  end

  private

  def self.from_pg_result(pg_result)
    pg_result.inject([]) { |books, book_hash| books << Book.new(book_hash["title"], "author_id1", "category_id1")} #author_id and category id needs work
  end

end
