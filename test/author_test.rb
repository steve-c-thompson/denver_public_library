require './test/test_helper'
require './lib/author'

class AuthorTest < Minitest::Test

  def test_it_exists
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    assert_instance_of Author, charlotte_bronte
  end

  def test_data_initialized_with_books
    author = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    assert_equal "Charlotte", author.first_name
    assert_equal "Bronte", author.last_name
    assert_equal [], author.books
  end

  def test_it_can_add_book_objects_and_return_them
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
    assert_equal 1, charlotte_bronte.books.count
    assert_equal "Charlotte", charlotte_bronte.books[0].author_first_name
    assert_equal "Bronte", charlotte_bronte.books[0].author_last_name
    assert_equal "Jane Eyre", charlotte_bronte.books[0].title
    assert_equal "October 16, 1847", charlotte_bronte.books[0].publication_date

    book = charlotte_bronte.add_book("Villette", "1853")
    assert_equal 2, charlotte_bronte.books.count
    assert_equal "Charlotte", charlotte_bronte.books[1].author_first_name
    assert_equal "Bronte", charlotte_bronte.books[1].author_last_name
    assert_equal "Villette", charlotte_bronte.books[1].title
    assert_equal "1853", charlotte_bronte.books[1].publication_date
    assert_instance_of Book, book
    assert_equal "Villette", book.title
  end
end
