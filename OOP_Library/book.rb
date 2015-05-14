require_relative "modules"


module Lib
  class Book
    include Jsonable

    attr_reader :title, :author, :times_taken, :id

    def initialize(title, author, id)
      raise TypeError, 'Title must be a strings' unless title.is_a?(String)
      raise TypeError, 'Author must be an author' unless author.is_a?(Author)
      @title = title
      @author = author
      @times_taken = 0
      @id = id || self.object_id
    end

    def to_s
      "'#{@title}' by #{@author.name}"
    end

    def take
      @times_taken += 1
    end
  end
end