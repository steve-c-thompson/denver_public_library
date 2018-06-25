# Denver Public Library (DPL)

## Preparation

1. Fork this repository.
1. Clone your new repository to your local machine.
1. Run `bundle` from the command line.
1. Run `rake` from the command line.

## Tasks

Today we are going to build a system for a library to keep track of its books and their authors.

### Iteration 1 Books

 An existing Book class. We're going to add to the Book class so that it can respond to the following interaction pattern:

```ruby
> require './lib/book'
# => true

> book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})
# => #<Book:0x007f98a9c6ace8 ...>

> book.author_first_name
# => "Harper"

> book.author_last_name
# => "Lee"

> book.title
# => "To Kill a Mockingbird"

> book.publication_date
# => "1960"
```

### Iteration 2 Authors

Currently we have the beginnings of an Author class. Add to that class so that it can respond to the following interaction pattern:

```ruby
> require "./lib/author"
# => true

> charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
# => #<Author:0x007fb410ada400>

> charlotte_bronte.books
# => []

> charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
# => #<Book:0x007f98a9c6ace8 @author_first_name="Charlotte", @author_last_name="Bronte", @publication_date="1847", @title="Jane Eyre">

> charlotte_bronte.books
# => [#<Book:0x007f98a9c6ace8 @author_first_name="Charlotte", @author_last_name="Bronte", @publication_date="1847", @title="Jane Eyre">]

> charlotte_bronte.add_book("Villette", "1853")
# => #<Book:0x007f98a9c6ace8 @author_first_name="Charlotte", @author_last_name="Bronte", @publication_date="1853", @title="Villette">

> charlotte_bronte.books
# => [
      #<Book:0x007f98a9c6ace8 @author_first_name="Charlotte", @author_last_name="Bronte", @publication_date="10/16/1847", @title="Jane Eyre">,
      #<Book:0x007f98a9c6add3 @author_first_name="Charlotte", @author_last_name="Bronte", @publication_date="1853", @title="Villette">
    ]
```



### Iteration 3 Library - Add a collection
Add a Library class with the following functionality:

```ruby
> require './lib/library'
> require './lib/author'

> charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
> jane_eyre = charlotte_bronte.add_book("Jane Eyre", "October 16, 1847")
> villette  = charlotte_bronte.add_book("Villette", "1853")

> harper_lee  = Author.new({first_name: "Harper", last_name: "Lee"})
> mockingbird = harper_lee.add_book("To Kill a Mockingbird", "July 11, 1960")

> dpl = Library.new
# => #<Library:0x007fb41101f2f8>

> dpl.books
# => []

> dpl.add_to_collection(jane_eyre)
> dpl.books
# => [#<Book:0x007f98a9c6ace8...>]

> dpl.add_to_collection(mockingbird)
> dpl.add_to_collection(villette)
> dpl.books
# => [#<Book:0x007f98a9c6ace8...>, #<Book:0x007fb410e8e1f0...>, #<Book:0x007fb410ea56e8...>]
```

### Iteration 4 Library - Get information about the collection
For this iteration, assume dpl is loaded with data from iteration 3.

```ruby
> dpl.include?("To Kill a Mockingbird")
# => true

> dpl.include?("A Connecticut Yankee in King Arthur's Court")
# => false

> dpl.card_catalogue
# NOTE:this method returns an array of books in alphabetical order by author's last name
# => [#<Book:0x007f98a9c6ace8 @author_last_name="Bronte"...>, #<Book:0x007fb410ea56e8 @author_last_name="Bronte"...>, #<Book:0x007fb410e8e1f0 @author_last_name="Lee"...> ]
```

### Iteration 5 Library - search
For this iteration, assume dpl is loaded with data from iteration 3.

```ruby
> dpl.find_by_author("Charlotte Bronte")
# => {
#     "Jane Eyre" => #<Book:0x007f98a9c6ace8 @author_last_name="Bronte" @title="Jane Eyre"...>,
#     "Villette"  => #<Book:0x007fb410ea56e8 @author_last_name="Bronte" @title="Villette"...>
#    }

> dpl.find_by_publication_date("1960")
# => {
#     "To Kill a Mockingbird" => #<Book:0x007fb410e8e1f0 @publication_date="1960"...>
#    }

```
