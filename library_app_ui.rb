require './lib/book'
require './lib/author'
require './lib/genre'

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

def menu_patron
  choice = nil
  until choice == 'q'
    puts "Press the following keys to navigate the library catalog:"
    common_choices
  end
end

def menu_librarian
  choice = nil
  until choice == 'q'
    puts "Press 'b' for basic menu or 'a' for admin menu."
    case choice
    when 'b'
      common_choices
    when 'a'
      choice = nil
      until choice == 'q'
        puts "Press 'b' to add a book to the catalog, 'd' to delete a book"
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
  puts "Enter the title of the book you would like to add:"
  title = gets.chomp
  puts "Enter the authors first name:"
  fisrt_name = gets.chomp
  puts "Enter the authors last name:"
  last_name = gets.chomp
  puts "Enter the category:"
  category = gets.chomp
  author = Author.find_by_name(first_name, last_name)
  author_id = author.author_id
  if author == nil
    author_id = Author.new(first_name, last_name).save
  end
  genre = Genre.find_by_name(category)
  if genre == nil
    category_id = Genre.new(category)
  end
  book = Book.new(title, author_id, category_id)
  book.save
end













