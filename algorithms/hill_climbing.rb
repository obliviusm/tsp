require_relative "../lib/tsp_solution"
require_relative "../lib/neighborhood"
require_relative "../lib/single_solution_based"

class HillClimbing
  include Neighborhood
  extend SingleSolutionBased
  attr_reader :solution
  
  def initialize w, x
    @solution = TSPSolution.new(w, x)
    @n = @solution.n # is used in Neighborhood
  end
  
  def solve
    begin 
      found_new_solution = false
      neighborhood do |solution_new|
        if solution_new < @solution
          @solution = solution_new
          found_new_solution = true
          break
        end
      end
    end while found_new_solution
    @solution
  end
end