class Genre

  attr_reader :category, :category_id

  def initialize(category, category_id = nil)
    @category = category
    @category_id = category_id
  end

  def self.all
    Genre.from_pg_result(DB.exec("SELECT * FROM genre;"))
  end

  def save
    @category_id = DB.exec("INSERT INTO genre (category) VALUES ('#{@category}') RETURNING category_id;").map {|result| result['category_id']}.first
  end

  def self.find_by_genre(category)
    #might need logic here to return the category depending on if they exist in the database
    genre = Genre.from_pg_result(DB.exec("SELECT * FROM genre WHERE category = '#{category}'")).first
  end

  def ==(other)
    self.category == other.category && self.category_id == other.category_id 
  end

  private

  def self.from_pg_result(pg_result)
    pg_result.inject([]) { |genres, genre_hash| genres << Genre.new(genre_hash['category'], genre_hash['category_id'])}
  end


end