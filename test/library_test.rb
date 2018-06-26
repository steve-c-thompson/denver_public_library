require './test/test_helper'
require './lib/library'
require './lib/author'
require './lib/book'

class LibraryTest < Minitest::Test
  def test_it_exists
    library = Library.new
    assert_instance_of Library, library
    assert_instance_of Array, library.books
    assert_equal 0, library.books.count
  end

  def test_it_can_add_book_to_collection
    dpl = Library.new
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
    villette  = charlotte_bronte.add_book("Villette", "1853")
    dpl.add_to_collection(jane_eyre)

    books = dpl.books
    assert_instance_of Array, books
    assert_equal 1, books.count
    assert_equal "Jane Eyre", books[0].title

    harper_lee  = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.add_book("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_to_collection(mockingbird)
    dpl.add_to_collection(villette)
    assert_equal 3, dpl.books.count
    assert_equal "Villette", dpl.books[2].title
  end

end
