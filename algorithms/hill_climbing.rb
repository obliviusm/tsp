require_relative "../lib/tsp_solution"
require_relative "../lib/neighborhood"
require_relative "../lib/tsp_solved_data"
require_relative "../services/timer"


class HillClimbing
  include Neighborhood
  
  def initialize w, x
    @solution = TSPSolution.new(w, x)
    @n = @solution.n # is used in Neighborhood
  end

  def solve
    s = @solution
    t = Timer.exec_time do
      algorithm
    end
    f = @solution
    TSPSolvedData.new(s, f, t)
  end
  
  def algorithm
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