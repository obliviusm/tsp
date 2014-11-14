class LocalSearch
  attr_reader :x, :f
  
  def initialize w, x
    @w = w            # graph weights
    @x = x            # current path through cities
    @n = x.size - 1   # last index in x
    @f = distance(x)  # length of current path
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
  
  protected
  
  def neighborhood
    swap_indices.each do |i, j|
      x = swap(i, j, @x)
      f = swap_distance(i, j, @x.dup, @f)
      #f = distance x
      yield x, f
    end
  end
  
  def swap_indices
    unless @swap_indices
      set_swap_indices
    end
    @swap_indices
  end
  
  def set_swap_indices
    @swap_indices = []
    for i in 0...@n
      for j in (i + 1)..@n
        @swap_indices.push [i, j]
      end
    end
  end
  
  def swap i, j, x
    x_copy = x.dup
    x_copy[i], x_copy[j] = x_copy[j], x_copy[i]
    x_copy
  end
  
  def distance x
    length = 0
    for i in 0...@n
      #p [from, to, @w[from][to]]
      length += w i, i+1, x
    end
    length += w @n, 0, x
    length
  end
  
  def w i, j, x
    @w[x[i]][x[j]]
  end
  
  def swap_distance i, j, x, f
    i0, i1, i2 = x[i - 1], x[i], x[i + 1]
    j0, j1, j2 = x[j - 1], x[j], x[j + 1]
    j2 = x[0] if j == @n 
    #p [@n, i, j, i0, i1, i2, j0, j1, j2]
    delta = 0
    if i == 0 && j == @n
      delta = (@w[j0][i1] + @w[i1][j1] + @w[j1][i2]) -(@w[j0][j1] + @w[j1][i1] + @w[i1][i2])
    else
      if j - i == 1
        delta = (@w[i1][j2] + @w[j1][i1]) - (@w[i1][j1] + @w[j1][j2])
      else
        delta = (@w[j0][i1] + @w[i1][j2] + @w[j1][i2]) - (@w[i1][i2] + @w[j0][j1] + @w[j1][j2])
      end
      delta += @w[i0][j1] - @w[i0][i1]
    end
    
    f_new = f + delta
=begin
    f_right =  distance(swap(i, j, x))
    unless f_new == f_right
      p [f, f_new, f_right, delta]
      raise "foo"
    end
=end
    f_new
  end
end