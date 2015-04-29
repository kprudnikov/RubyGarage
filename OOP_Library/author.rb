require_relative "modules"

class Author
  include Jsonable
  attr_accessor :biography
  attr_reader :name, :id

  def initialize(name, biography, id)
    @name = name
    @biography = biography || ""
    @id = id || self.object_id
  end
end