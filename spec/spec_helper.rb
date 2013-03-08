require 'validate'
require 'rspec'
require 'pg'
require 'book'
require 'author'
require 'genre'


RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM book *;")
    DB.exec("DELETE FROM author *;")
    DB.exec("DELETE FROM genre *;")
  end
end


DB = PG.connect(:dbname => 'library_test', :host => 'localhost')