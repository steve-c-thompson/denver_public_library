class Library
  attr_reader :books
  def initialize
    @books = []
  end

  def add_to_collection(book)
    @books.push(book)
  end

  def include?(title)
    @books.any? {|book| book.title == title}
  end

  def card_catalog
    books.sort_by {|b| [b.author_last_name, b.title]}
  end
end
