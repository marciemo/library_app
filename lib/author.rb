class Author
  include Validate

  attr_reader :first_name, :last_name, :author_id

  def initialize(first_name = nil, last_name = nil, author_id = nil)
    @first_name = first_name
    @last_name = last_name
    @author_id = author_id
  end

  def self.all
    Author.from_pg_result(DB.exec("SELECT * FROM author;"))
  end

  def save
    @author_id = DB.exec("INSERT INTO author (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING author_id;").map {|result| result['author_id']}.first
  end

  def self.find_by_name(first_name, last_name)
    #might need logic here to return the author depending on if they exist in the database
    author = Author.from_pg_result(DB.exec("SELECT * FROM author WHERE first_name = '#{first_name}' and last_name = '#{last_name}'")).first
  end


  def ==(other)
    if other.class != self.class
      false
    else
      self.first_name == other.first_name && self.last_name == other.last_name && self.author_id == other.author_id
    end
  end

  # def self.save_if_new_author(first_name, last_name)
  #   if self == nil 
  #     p Author.new(first_name, last_name).save
  #   end
  # end

  private

  def self.from_pg_result(pg_result)
    pg_result.inject([]) { |authors, author_hash| authors << Author.new(author_hash['first_name'], author_hash['last_name'], author_hash['author_id'])}
  end



end

