require_relative "../lib/tsp_solution"
require_relative "../lib/neighborhood"
require_relative "../lib/solve_with_timer"

class SimulatedAnnealing
  include Neighborhood
  include SolveWithTimer
  
  def initialize w, x
    @solution = TSPSolution.new(w, x)
    @n = @solution.n # is used in Neighborhood
  end
  
  def algorithm
    begin 
      found_new_solution = false
      neighborhood(true) do |solution_new|
        if solution_new < @solution
          @solution = solution_new
          found_new_solution = true
          break
        end
      end
    end while found_new_solution
  end
end