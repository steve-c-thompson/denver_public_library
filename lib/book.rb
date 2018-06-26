class Book
  attr_reader :author_first_name
  attr_reader :author_last_name
  attr_reader :publication_date
  attr_reader :title
  def initialize(data)
    @author_first_name = data[:author_first_name]
    @author_last_name = data[:author_last_name]
    @title = data[:title]
    @publication_date = data[:publication_date]
  end

end
