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

  def find_by_author(author)
    arr = @books.select { |book| book.author_first_name + " " + book.author_last_name == author}
    sort_and_map arr
  end

  def find_by_publication_date(date)
    arr = @books.select { |book| book.publication_date.end_with? date}  # Not a fan of leaving off parens
    sort_and_map arr
  end

  private
  def sort_and_map(arr)
    arr.sort_by! { |b| b.title}
    val = {}
    arr.each do |book|
      val[book.title] = book
    end
    val.sort_by{|key, book| key}
    val
  end
end
