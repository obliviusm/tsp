require_relative "../lib/tsp_solution"
require_relative "../lib/neighborhood"
class LocalSearch
  include Neighborhood
  
  def initialize w, x
    @solution = TSPSolution.new(w, x)
    @n = @solution.n
  end
  
  def f
    @solution.f
  end
  
  def simple_local_search
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