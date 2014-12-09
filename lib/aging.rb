module Aging
  attr_accessor :age

  def grow_up
    #p @age
    @age = (@age || 0) + 1
  end
end