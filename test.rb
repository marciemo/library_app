# contact_id = DB.exec("SELECT contact_id FROM name WHERE name.name = '#{name}'").map { |info| info }.first['contact_id']
    result = DB.exec("SELECT book.title, author.first_name, author.last_name, genre.category 
                      FROM book, author, genre 
                      WHERE book.title = 'whatever' and author.author_id = '12' and genre.category_id = '12'; and mailing_address.contact_id = '#{contact_id}' and phone_number.contact_id = '#{contact_id}';").map { |info| info }
  end