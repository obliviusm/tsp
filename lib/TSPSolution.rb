class TSPSolution
  attr_reader :x, :f
  
  def initialize w, x, f = nil
    @w = w              # graph weights
    @x = x              # path through cities
    @n = x.size - 1     # last index in x
    @f = f || distance  # length of path
  end
  
  def swap i, j
    
  end
  
  protected
  
  def distance
    length = 0
    for i in 0...@n
      length += edge i, i+1
    end
    length += edge @n, 0
    length
  end
  
  def edge i, j
    @w[@x[i]][@x[j]]
  end
end