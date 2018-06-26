class Author
  attr_reader :first_name
  attr_reader :last_name
  attr_reader :books

  def initialize(data)
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @books = []
  end

  def add_book(title, publication_date)
    book = Book.new({author_first_name: @first_name, author_last_name: @last_name, title: title, publication_date: publication_date})
    @books.push(book)
  end
end
