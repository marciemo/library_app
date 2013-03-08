require 'spec_helper'

describe Book do 

  context '#initialize' do 
    it 'should create an instance of book' do 
      Book.new('test', 'test', 'test').should be_an_instance_of Book 
    end
  end

  context 'readers' do
    it 'returns the value for title' do
      book = Book.new('title', 5, 7)
      book.title.should eq 'title'
    end

    it 'returns the value for author' do
      book = Book.new('title', 5, 7)
      book.author_id.should eq 5
    end

    it 'returns the value for category' do
      book = Book.new('title', 5, 7)
      book.category_id.should eq 7
    end
  end

  context '#save' do 
    it 'saves the book title to book table' do
      book = Book.new('title', 5, 7)
      expect {book.save}.to change {Book.all.length}.by 1
    end
  end

  context '.all' do
    it 'lists all the books in the library' do
      books = [['title1', 1, 1], ['title2', 2, 2], ['title3', 3, 3]]
      books.each {|book| Book.new(*book).save}
      Book.all.map {|book| book.title}. should =~ books.map {|book| book.first }
    end
  end

  context 'search' do
    it 'finds all the books with desired title' do
      author_id = Author.new('mike', 'piccolo').save
      category_id = Genre.new('fiction').save
      books = [['title1', author_id, category_id], ['title2', 2, 2], ['title3', 3, 3]]
      books.each {|book| Book.new(*book).save}
      Book.search('title1').should eq ["title1", "mike", "piccolo", "fiction"]
    end
  end



end







