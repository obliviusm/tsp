class LocalSearch
  attr_reader :x, :f
  
  def initialize w, x
    @w = w    # graph weights
    @x = x    # current path through cities
    @f = distance(x) # length of current path
  end
  
  def simple_local_search
    begin 
      found_new_solution = false
      neighborhood do |x_new, f_new|
        if f_new < @f
          @x, @f = x_new, f_new
          found_new_solution = true
          break
        end
      end
    end while found_new_solution
    @x
  end
  
  private
  
  def neighborhood
    for i in 0...(@x.size - 1)
      for j in (i + 1)..(@x.size - 1)
        x = swap(i, j, @x)
        yield x, distance(x)
      end
    end
  end
  
  def swap i, j, x
    x_copy = x
    x_copy[i], x_copy[j] = x_copy[j], x_copy[i]
    x_copy
  end
  
  def distance x
    length = 0
    for i in 0...(x.size - 1)
      from, to = x[i], x[i+1]
      length += @w[from][to]
    end
    length
  end
end