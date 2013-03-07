require 'spec_helper'

describe Genre do

  context '#initialize' do
    it 'creates an instance of Genre' do
      Genre.new('category').should be_an_instance_of Genre
    end
  end

  context 'readers' do
    it 'returns the value for category' do
      genre = Genre.new('category')
      genre.category.should eq 'category'
    end

    it 'returns a value or nil for genre_id' do
      Genre.new('category').save.should be_kind_of(String)
    end
  end

  context '#save' do 
    it 'saves the category name to genre table' do
      genre = Genre.new('category')
      expect {genre.save}.to change {Genre.all.length}.by 1
    end
  end

  context '.all' do
    it 'lists all the genres in the library' do
      genres = [['category1'], ['category2'], ['category3']]
      genres.each {|genre| Genre.new(*genre).save}
      Genre.all.map {|genre| genre.category}.should =~ genres.map {|genre| genre.first }
    end
  end

  context '#==' do
    it 'considers two objects equal if their category and category_id are equal' do
      genre1 = Genre.new('category1')
      genre2 = Genre.new('category1')
      genre1.should eq genre2
    end
  end

  context '#find_by_genre' do
    it 'checks the genre table to find if genre name exists in db' do 
      genre_to_be_found = Genre.new('category')
      genre_to_be_found.save
      fake_genre = Genre.new('category')
      fake_genre.save
      genre = Genre.find_by_genre('category').should eq genre_to_be_found
    end
  end

    # it 'saves the author if they do not exists yet in the database' do
    #   fake_author1 = Author.new('first_name1', 'last_name1')
    #   fake_author1.save
    #   fake_author2 = Author.new('first_name2', 'last_name2')
    #   fake_author2.save
    #   Author.find_by_name('first_name3', 'last_name3')#.to change {Author.all.length}.by 1
    # end
  # end
end