require_relative "../lib/tsp_solution"
require_relative "../lib/neighborhood"
require_relative "../services/timer"

class LocalSearch
  include Neighborhood
  
  def initialize w, x
    @solution = TSPSolution.new(w, x)
    @n = @solution.n
  end
  
  #def f
  #  @solution.f
  #end

  def solve
    s = @solution
    t = Timer.exec_time do
      simple_local_search
    end
    f = @solution
    #{s: s.f, f: f.f, t: t}
    TSPSolvedData.new(s, f, t)
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