require './lib/book'
require './lib/author'
require './lib/genre'
require 'pg'

DB = PG.connect(:dbname => 'library', :host => 'localhost')

# def clear_database
#   DB.exec("DELETE FROM book *;")
#   DB.exec("DELETE FROM author *;")
#   DB.exec("DELETE FROM genre *;")
# end

def welcome
  puts "Welcome to the Epicodus Public Library"
  user = nil
  puts "Enter 'p' if you are a patron or 'l' if you are a librarian."
  user = gets.chomp
  case user
  when 'p'
    menu_patron
  when 'l'
    menu_librarian
  else
    invalid
  end
end


def self.menu_patron
  choice = nil
  until choice == 'q'
    puts "Press the following keys to navigate the library catalog:"
    common_choices
  end
end

def self.menu_librarian
  choice = nil
  until choice == 'q'
    puts "Press 'b' for basic menu or 'a' for admin menu."
    choice = gets.chomp
    case choice
    when 'b'
      common_choices
    when 'a'
      choice = nil
      until choice == 'q'
        puts "Press 'b' to add a book to the catalog, 'd' to delete a book or press 'r' to return to menu"
        choice = gets.chomp
        case choice
        when 'b'
          add_book
        when 'd'
          delete_book
        when 'q'
          quit
        else
          invalid
        end
      end
    end
  end
end

def common_choices
  puts "'l' for a list of authors, 't' for title search, 'a' for author search, 'c' for category search."
  puts "Press 'q' to quit."
  choice = gets.chomp
  case choice
  when 'l'
    author_list
  when 't'
    title_search
  when 'a'
    author_search
  when 'c'
    category_search
  when 'q'
    quit
  else
    invalid
  end
end

def add_book
  title = nil
  author = nil
  category = nil
  first_name = nil
  last_name = nil
  puts "Enter the title of the book you would like to add:"
  title = gets.chomp
  puts "Enter the authors first name:"
  first_name = gets.chomp
  puts "Enter the authors last name:"
  last_name = gets.chomp
  puts "Enter the category:"
  category = gets.chomp
  author = Author.find_by_name(first_name, last_name)
  if author == nil
    author_id = Author.new(first_name, last_name).save
  else
    p author_id = author.author_id
  end
  genre = Genre.find_by_genre(category)
  if genre == nil
    category_id = Genre.new(category).save
  end
  book = Book.new(title, author_id, category_id)
  book.save
end

# clear_database
welcome











