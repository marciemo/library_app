require 'spec_helper'

describe Author do

  context '#initialize' do
    it 'creates an instance of Author' do
      Author.new('first_name', 'last_name').should be_an_instance_of Author
    end
  end

  context 'readers' do
    it 'returns the value for first_name' do
      author = Author.new('first_name', 'last_name')
      author.first_name.should eq 'first_name'
    end

    it 'returns the value for author' do
      author = Author.new('first_name', 'last_name')
      author.last_name.should eq 'last_name'
    end

    it 'returns a value or nil for author_id' do
      Author.new('first_name', 'last_name').save.should be_kind_of(String)
    end
  end

  context '#save' do 
    it 'saves the author name to author table' do
      author = Author.new('first_name', 'last_name')
      expect {author.save}.to change {Author.all.length}.by 1
    end
  end

  context '.all' do
    it 'lists all the authors in the library' do
      authors = [['first_name1', 'last_name1'], ['first_name2', 'last_name2'], ['first_name3', 'last_name3']]
      authors.each {|author| Author.new(*author).save}
      Author.all.map {|author| author.first_name}.should =~ authors.map {|author| author.first }
    end
  end

  context '#==' do
    it 'considers two objects equal if their last_name, first_name and author_id are equal' do
      author1 = Author.new('first_name', 'last_name', '22')
      author2 = Author.new('first_name', 'last_name', '22')
      author1.should === author2
    end
  end

  context '#find_by_name' do
    it 'checks the author table to find if author name exists in db' do 
      author_to_be_found = Author.new('first_name1', 'last_name1')
      author_to_be_found.save
      fake_author = Author.new('first_name2', 'last_name2')
      fake_author.save
      author = Author.find_by_name('first_name1', 'last_name1').should === author_to_be_found
    end

    # it 'saves the author if they do not exists yet in the database' do
    #   fake_author1 = Author.new('first_name1', 'last_name1')
    #   fake_author1.save
    #   fake_author2 = Author.new('first_name2', 'last_name2')
    #   fake_author2.save
    #   Author.find_by_name('first_name3', 'last_name3')#.to change {Author.all.length}.by 1
    # end
  end
end











