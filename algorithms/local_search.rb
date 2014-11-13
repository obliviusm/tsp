class LocalSearch
  attr_reader :x, :f
  
  def initialize w, x
    @w = w            # graph weights
    @x = x            # current path through cities
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
    for i in 0...(@x.size - 1)
      for j in (i + 1)..(@x.size - 1)
        x = swap(i, j, @x)
        #f = swap_distance2(i, j, @x.dup, @f)
        f = distance x
        yield x, f
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
    for i in 0...(x.size - 1)
      #p [from, to, @w[from][to]]
      length += w i, i+1, x
    end
    length += w x.size-1, 0, x
    length
  end
  
  def w i, j, x
    @w[x[i]][x[j]]
  end
=begin
  def swap_distance i, j, x, f
    c = Array.new(8, 0) # [0, 0, 0, 0, 0, 0, 0, 0]
    positions = [[i-1, i], [i, i+1], [j-1, j], [j, j+1], [i-1, j], [j, i+1], [j-1,i], [i, j+1]]
    positions.each_with_index do |(s, d), index| # source, dest, index
      max_position = @x.size - 1
      if s >= 0 && d >= 0 && s <= max_position && d <= max_position
        source_i, dest_i = x[s], x[d]
        p [s, d, source_i, dest_i]
        c[index] = @w[source_i][dest_i]
        c[index] *= -1 if index < 4
      end
    end
    
    p c, positions, f
 
    f - c.inject(:+)
  end
  
  def swap_distance2 i, j, x, f
    for k in 0...(x.size - 1)
      next if ([k, k+1] & [i, j]).empty?
      f -= @w[x[k]][x[k+1]]
    end
    x = swap i, j, x
    for k in 0...(x.size - 1)
      next if ([k, k+1] & [i, j]).empty?
      f += @w[x[k]][x[k+1]]
    end
    f
  end
=end
end