require 'spec_helper'

describe Book do 

  context '#initialize' do 
    it 'should create an instance of book' do 
      Book.new('test', 'test', 'test').should be_an_instance_of Book 
    end
  end

  context 'readers' do
    it 'returns the value for title' do
      book = Book.new('title', 'author', 'category')
      book.title.should eq 'title'
    end

    it 'returns the value for author' do
      book = Book.new('title', 'author', 'category')
      book.author_id.should eq 'author'
    end

    it 'returns the value for category' do
      book = Book.new('title', 'author', 'category')
      book.category_id.should eq 'category'
    end
  end

  context '#save' do 
    it 'saves the book title to book table' do
      book = Book.new('title', 'author', 'category')
      expect {book.save}.to change {Book.all.length}.by 1
    end
  end

  context '.all' do
    it 'lists all the books in the library' do
      books = [['title1', 'author1', 'category1'], ['title2', 'author2', 'category2'], ['title3', 'author3', 'category3']]
      books.each {|book| Book.new(*book).save}
      Book.all.map {|book| book.title}. should =~ books.map {|book| book.first }
    end
  end



end







