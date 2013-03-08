require './lib/validate'
require './lib/book'
require './lib/author'
require './lib/genre'
require 'pg'

DB = PG.connect(:dbname => 'library', :host => 'localhost')

def clear_database
  DB.exec("DELETE FROM book *;")
  DB.exec("DELETE FROM author *;")
  DB.exec("DELETE FROM genre *;")
end

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
      until choice == 'r'
        puts "Press 'b' to add a book to the catalog, 'd' to delete a book or press 'r' to return to menu"
        choice = gets.chomp
        case choice
        when 'b'
          add_book
        when 'd'
          delete_book
        when 'g'
          add_genre
        when 'r'
          menu_librarian
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
  valid_input = nil
  until valid_input != nil
    puts "Enter the title of the book you would like to add:"
    title = gets.chomp
    book = Book.new(title)
    valid_input = book.valid_input?(title)
    next if valid_input != nil
      puts "Sorry that is not a valid title. Try again. \n\n"
  end
  valid_input = nil
  until valid_input != nil
    puts "Enter the authors first name:"
    first_name = gets.chomp
    author = Author.new(first_name)
    valid_input = author.valid_input?(first_name)
    next if valid_input != nil
      puts "Sorry that is not a valid name. Try again. \n\n"
  end
  valid_input = nil
  until valid_input != nil
    puts "Enter the authors last name:"
    last_name = gets.chomp
    author = Author.new(last_name)
    valid_input = author.valid_input?(last_name)
    next if valid_input != nil
      puts "Sorry that is not a valid name. Try again. \n\n"
  end
  author = Author.find_by_name(first_name, last_name)
  if author == nil
    author_id = Author.new(first_name, last_name).save
  else
    author_id = author.author_id
  end
  valid_input = nil
  until valid_input != nil
  puts "Enter the category from these choices:"
  category = gets.chomp
  genre = Genre.new(category)
    valid_input = genre.valid_input?(category)
    next if valid_input != nil
      puts "Sorry that is not a valid category name. Try again. \n\n"
  end
  genre = Genre.find_by_genre(category)
  if genre == nil
    puts "#{category} does not exist.  Would you like to create it? (y/n)?"
    choice = gets.chomp
    case choice
    when 'y'
    category_id = Genre.new(category).save
    when 'n'
      add_book
    end
  else
    category_id = genre.category_id
  end
  book = Book.new(title, author_id, category_id)
  book.save
end

def author_list
  DB.exec("SELECT * FROM author;")
end

def title_search
  puts "Please enter in a book title:"
  choice = gets.chomp
  result = Book.search(choice).map { |result| result.capitalize }
  puts result.join(" ")
end

# def author_search

# end

def from_pg_result_ui(pg_result, choice)
  pg_result.inject([]) { |items, item_hash| items << Book.new(item_hash[choice], item_hash["author_id"], item_hash["category_id"])} #author_id and category id needs work
end

# clear_database
welcome











