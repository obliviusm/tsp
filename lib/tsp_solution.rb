require_relative "swap_two_elements"
require_relative "crossover"
require_relative "x_comparator"
class TSPSolution
  include Comparable
  include SwapTwoElements
  include Crossover
  include XComparator
  attr_reader :w, :n, :x, :f
  
  def initialize w, x, f = nil
    @w = w              # graph weights
    @x = x              # path through cities
    @n = x.size - 1     # last index in x
    @f = f || distance  # length of path
  end
  
  def <=> (other)
    @f <=> other.f
  end

  def self.new_array graph, solution_paths
    solution_paths.map do |path|
      self.new graph, path
    end
  end
  
  protected
  
  def distance
    length = 0
    for i in 0...n
      length += edge i, i+1
    end
    length += edge n, 0
    length
  end
  
  def edge i, j
    w[x[i]][x[j]]
  end
end