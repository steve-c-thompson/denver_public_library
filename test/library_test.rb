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

  def test_it_returns_true_for_titles_in_books_collection
    dpl = Library.new
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
    villette  = charlotte_bronte.add_book("Villette", "1853")
    dpl.add_to_collection(jane_eyre)

    harper_lee  = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.add_book("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_to_collection(mockingbird)
    dpl.add_to_collection(villette)

    assert dpl.include?("To Kill a Mockingbird")
    refute dpl.include?("A Connecticut Viking in King Arthur's Court")
  end

  def test_card_catalog_returns_array_of_books_in_alphabetical_order_sorted_by_author_last_name
    dpl = Library.new
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
    villette  = charlotte_bronte.add_book("Villette", "1853")
    dpl.add_to_collection(jane_eyre)

    harper_lee  = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.add_book("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_to_collection(mockingbird)
    dpl.add_to_collection(villette)

    books = dpl.card_catalog
    assert_equal 3, books.count
    assert_equal "Bronte", books[0].author_last_name
    assert_equal "Jane Eyre", books[0].title
    assert_equal "Bronte", books[1].author_last_name
    assert_equal "Villette", books[1].title
    assert_equal "Lee", books[2].author_last_name
  end

  def test_find_by_author_returns_hash_of_authors_books_in_alphabetical_order_with_title_as_key
    dpl = Library.new
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
    villette  = charlotte_bronte.add_book("Villette", "1853")
    dpl.add_to_collection(jane_eyre)

    harper_lee  = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.add_book("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_to_collection(mockingbird)
    dpl.add_to_collection(villette)

    cb = dpl.find_by_author("Charlotte Bronte")
    assert_equal 2, cb.count
    assert_equal "Jane Eyre", cb["Jane Eyre"].title
    assert_equal "October 16, 1847", cb["Jane Eyre"].publication_date
    assert_equal "1853", cb["Villette"].publication_date
  end

  def test_find_by_author_returns_empty_hash_for_no_author
    dpl = Library.new
    ds = dpl.find_by_author("Dr. Seuss")
    refute_nil ds
    assert_instance_of Hash, ds
    assert_equal 0, ds.size
  end

  def test_find_by_publication_date_returns_empty_hash_for_no_date
    dpl = Library.new
    ds = dpl.find_by_publication_date("1999")
    refute_nil ds
    assert_instance_of Hash, ds
    assert_equal 0, ds.size
  end

  def test_find_by_publication_date_returns_hash_of_books_with_year_by_title_ascending
    dpl = Library.new
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
    villette  = charlotte_bronte.add_book("Villette", "1853")
    dpl.add_to_collection(jane_eyre)

    harper_lee  = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.add_book("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_to_collection(mockingbird)
    dpl.add_to_collection(villette)

    sixty = dpl.find_by_publication_date("1960")
    assert_equal 1, sixty.count
    assert_equal "To Kill a Mockingbird", sixty["To Kill a Mockingbird"].title
    assert_equal "July 11, 1960", sixty["To Kill a Mockingbird"].publication_date

    mockingbird2 = harper_lee.add_book("To Kill a Mockingbird 2", "July 12, 1960")
    dpl.add_to_collection(mockingbird2)
    sixty = dpl.find_by_publication_date("1960")
    assert_equal 2, sixty.count
    assert_equal "To Kill a Mockingbird", sixty["To Kill a Mockingbird"].title
    assert_equal "To Kill a Mockingbird 2", sixty["To Kill a Mockingbird 2"].title
  end
end
